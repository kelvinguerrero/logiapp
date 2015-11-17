class MiddlemenController < ApplicationController
  before_action :set_middleman, only: [:show, :edit, :update, :destroy]

  # GET /middlemen
  # GET /middlemen.json
  def index
    @middlemen = Middleman.all
  end

  # GET /middlemen/1
  # GET /middlemen/1.json
  def show
  end

  # GET /middlemen/new
  def new
    @middleman = Middleman.new
  end

  # GET /middlemen/1/edit
  def edit
  end

  # POST /middlemen
  # POST /middlemen.json
  def create
    @middleman = Middleman.new(middleman_params)

    respond_to do |format|
      if @middleman.save
        format.html { redirect_to @middleman, notice: 'Middleman was successfully created.' }
        format.json { render :show, status: :created, location: @middleman }
      else
        format.html { render :new }
        format.json { render json: @middleman.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /middlemen/1
  # PATCH/PUT /middlemen/1.json
  def update
    respond_to do |format|
      if @middleman.update(middleman_params)
        format.html { redirect_to @middleman, notice: 'Middleman was successfully updated.' }
        format.json { render :show, status: :ok, location: @middleman }
      else
        format.html { render :edit }
        format.json { render json: @middleman.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /middlemen/1
  # DELETE /middlemen/1.json
  def destroy
    @middleman.destroy
    respond_to do |format|
      format.html { redirect_to middlemen_url, notice: 'Middleman was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_middleman
      @middleman = Middleman.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def middleman_params
      params.require(:middleman).permit(:name, :price)
    end
end
