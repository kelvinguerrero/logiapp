class NaviesController < ApplicationController
  before_action :set_navy, only: [:show, :edit, :update, :destroy]

  # GET /navies
  # GET /navies.json
  def index
    @navies = Navy.all
  end

  # GET /navies/1
  # GET /navies/1.json
  def show
  end

  # GET /navies/new
  def new
    @navy = Navy.new
  end

  # GET /navies/1/edit
  def edit
  end

  # POST /navies
  # POST /navies.json
  def create
    @navy = Navy.new(navy_params)

    respond_to do |format|
      if @navy.save
        format.html { redirect_to @navy, notice: 'Navy was successfully created.' }
        format.json { render :show, status: :created, location: @navy }
      else
        format.html { render :new }
        format.json { render json: @navy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /navies/1
  # PATCH/PUT /navies/1.json
  def update
    respond_to do |format|
      if @navy.update(navy_params)
        format.html { redirect_to @navy, notice: 'Navy was successfully updated.' }
        format.json { render :show, status: :ok, location: @navy }
      else
        format.html { render :edit }
        format.json { render json: @navy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /navies/1
  # DELETE /navies/1.json
  def destroy
    @navy.destroy
    respond_to do |format|
      format.html { redirect_to navies_url, notice: 'Navy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
    def set_navy
      @navy = Navy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def navy_params
      params.require(:navy).permit(:name)
    end
end
