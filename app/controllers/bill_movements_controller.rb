class BillMovementsController < ApplicationController
  before_action :set_bill_movement, only: [:show, :edit, :update, :destroy]
  before_action :set_logi_bill_movement_transaction, only: [:bill_transaction]

  # GET /bill_movements
  # GET /bill_movements.json
  def index
    @bill_movements = BillMovement.all
  end

  # GET /bill_movements/1
  # GET /bill_movements/1.json
  def show
  end

  # GET /bill_movements/new
  def new
    @bill_movement = BillMovement.new
  end

  # GET /:id_bill/new_bill_movement
  def bill_transaction
    var_bill = BillMovementLogic.new
    var_bill.movement_enter_logi_bill(bill_transaction_params[:bill_movement_id], bill_transaction_params[:value_bill])
    respond_to do |format|
      format.html{ redirect_to @logi_bill and return }
    end
  end


  # GET /bill_movements/1/edit
  def edit
  end

  # POST /bill_movements
  # POST /bill_movements.json
  def create
    @bill_movement = BillMovement.new(bill_movement_params)

    respond_to do |format|
      if @bill_movement.save
        format.html { redirect_to @bill_movement, notice: 'Bill movement was successfully created.' }
        format.json { render :show, status: :created, location: @bill_movement }
      else
        format.html { render :new }
        format.json { render json: @bill_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bill_movements/1
  # PATCH/PUT /bill_movements/1.json
  def update
    respond_to do |format|
      if @bill_movement.update(bill_movement_params)
        format.html { redirect_to @bill_movement, notice: 'Bill movement was successfully updated.' }
        format.json { render :show, status: :ok, location: @bill_movement }
      else
        format.html { render :edit }
        format.json { render json: @bill_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bill_movements/1
  # DELETE /bill_movements/1.json
  def destroy
    @bill_movement.destroy
    respond_to do |format|
      format.html { redirect_to bill_movements_url, notice: 'Bill movement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill_movement
      @bill_movement = BillMovement.find(params[:id])
    end

  # Use callbacks to share common setup or constraints between actions.
  def set_logi_bill_movement_transaction
    @logi_bill = LogiBill.find(params[:bill_movement_id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_movement_params
      params.require(:bill_movement).permit(:total, :value, :lastChange)
      params.permit(:value_bill,:bill_movement_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_transaction_params
      params.permit(:value_bill,:bill_movement_id)
    end
end

