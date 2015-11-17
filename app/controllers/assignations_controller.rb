class AssignationsController < ApplicationController
  before_action :set_assignation, only: [:show, :edit, :update, :destroy]


  # GET /assignations
  # GET /assignations.json
  def index
    @assignations = Assignation.all
  end

  # GET /assignations/1
  # GET /assignations/1.json
  def show
  end

  # GET /assignations/new
  def new
    @assignation = Assignation.new
  end

  # GET /assignations/1/edit
  def edit
  end

  # POST /assignations
  # POST /assignations.json
  def create
    @assignation = Assignation.new(assignation_params)

    respond_to do |format|
      if @assignation.save
        format.html { redirect_to @assignation, notice: 'Assignation was successfully created.' }
        format.json { render :show, status: :created, location: @assignation }
      else
        format.html { render :new }
        format.json { render json: @assignation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignations/1
  # PATCH/PUT /assignations/1.json
  def update
    respond_to do |format|
      if @assignation.update(assignation_params)
        format.html { redirect_to @assignation, notice: 'Assignation was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignation }
      else
        format.html { render :edit }
        format.json { render json: @assignation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignations/1
  # DELETE /assignations/1.json
  def destroy
    @assignation.destroy
    respond_to do |format|
      format.html { redirect_to assignations_url, notice: 'Assignation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_assignation
      @assignation = Assignation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignation_params
      params.require(:assignation).permit(:shipment, :quantity, :workOrder, :startDate, :endDate, :price,
                                          :navy_id, :container_id, :way_id)
    end
end
