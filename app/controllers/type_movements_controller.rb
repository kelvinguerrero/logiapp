class TypeMovementsController < ApplicationController
  before_action :set_type_movement, only: [:show, :edit, :update, :destroy]

  # GET /type_movements
  # GET /type_movements.json
  def index
    @type_movements = TypeMovement.all
  end

  # GET /type_movements/1
  # GET /type_movements/1.json
  def show
  end

  # GET /type_movements/new
  def new
    @type_movement = TypeMovement.new
  end

  # GET /type_movements/1/edit
  def edit
  end

  # POST /type_movements
  # POST /type_movements.json
  def create
    @type_movement = TypeMovement.new(type_movement_params)

    respond_to do |format|
      if @type_movement.save
        format.html { redirect_to @type_movement, notice: 'Type movement was successfully created.' }
        format.json { render :show, status: :created, location: @type_movement }
      else
        format.html { render :new }
        format.json { render json: @type_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /type_movements/1
  # PATCH/PUT /type_movements/1.json
  def update
    respond_to do |format|
      if @type_movement.update(type_movement_params)
        format.html { redirect_to @type_movement, notice: 'Type movement was successfully updated.' }
        format.json { render :show, status: :ok, location: @type_movement }
      else
        format.html { render :edit }
        format.json { render json: @type_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /type_movements/1
  # DELETE /type_movements/1.json
  def destroy
    @type_movement.destroy
    respond_to do |format|
      format.html { redirect_to type_movements_url, notice: 'Type movement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type_movement
      @type_movement = TypeMovement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def type_movement_params
      params.require(:type_movement).permit(:name)
    end
end
