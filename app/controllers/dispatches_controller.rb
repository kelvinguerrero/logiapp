class DispatchesController < ApplicationController
  before_action :set_dispatch, only: [:show, :edit, :update, :destroy]

  # GET /dispatches
  # GET /dispatches.json
  def index
    @dispatches = Dispatch.all
  end

  # GET /dispatches/1
  # GET /dispatches/1.json
  def show
  end

  # GET /dispatches/new
  def new
    @dispatch = Dispatch.new
  end

  # GET /dispatches/1/edit
  def edit
  end

  # POST /dispatches
  # POST /dispatches.json
  def create
    @dispatch = Dispatch.new(dispatch_params)
    v_dispatch_logic = DispatchLogic.new(dispatch_params,@dispatch)
    respond_to do |format|
      Dispatch.transaction do
        begin
          begin
            if @dispatch.save
              v_dispatch_logic.create_dispatch_logic
              v_dispatch_logic.advance_accounting(@dispatch)
              format.html { redirect_to @dispatch, notice: 'El despacho fue creado existosamente.' }
              format.json { render :show, status: :created, location: @dispatch }
            else
              format.html { render :new }
              format.json { render json: @dispatch.errors, status: :unprocessable_entity }
            end
          rescue
            @dispatch.errors.add(:type_movement, ": Error en la generacion del despacho.")
            raise ActiveRecord::Rollback
          end
        rescue
          format.html { render :new }
          format.json { render json: @dispatch.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /dispatches/1
  # PATCH/PUT /dispatches/1.json
  def update
    respond_to do |format|
      Movement.transaction do
        begin
          begin
            anterior_advance = @dispatch.advance
            anterior_balance = @dispatch.balance
            if @dispatch.update(dispatch_params)
              v_dispatch_logic = DispatchLogic.new(dispatch_params,@dispatch)
              v_dispatch_logic.edit_dispatch_logic(@dispatch,anterior_advance,anterior_balance)
              format.html { redirect_to @dispatch, notice: 'Dispatch was successfully updated.' }
              format.json { render :show, status: :ok, location: @dispatch }
            else
              format.html { render :edit }
              format.json { render json: @dispatch.errors, status: :unprocessable_entity }
            end
          rescue
            @dispatch.errors.add(:type_movement, ": Error en la generacion del despacho.")
            raise ActiveRecord::Rollback
          end
        rescue
          format.html { render :new }
          format.json { render json: @dispatch.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /dispatches/1
  # DELETE /dispatches/1.json
  def destroy
    @dispatch.destroy
    respond_to do |format|
      format.html { redirect_to dispatches_url, notice: 'Dispatch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dispatch
      @dispatch = Dispatch.find(params[:id])
      @assignation = @dispatch.assignation
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dispatch_params
      params.require(:dispatch).permit(:manifestNumber, :loadOrder, :advance, :balance,
                                        :assignation_id, :middleman_id, :car_id, :driver_id,
                                        :deliverDate, :downloadDate, :advanceDate, :deadlineDate, :maximDeadlineDate, :paymentBalanceDate,
                                        :completeDate, :balancePay, :loadConcept, :unoccupied, :containerNumber)
    end
end



