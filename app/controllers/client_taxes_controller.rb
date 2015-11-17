class ClientTaxesController < ApplicationController
  before_action :set_client_tax, only: [:show, :edit, :update, :destroy]

  # GET /client_taxes
  # GET /client_taxes.json
  def index
    @client_taxes = ClientTax.all
  end

  # GET /client_taxes/1
  # GET /client_taxes/1.json
  def show
  end

  # GET /client_taxes/new
  def new
    @client_tax = ClientTax.new
  end

  # GET /client_taxes/1/edit
  def edit
  end

  # POST /client_taxes
  # POST /client_taxes.json
  def create
    @client_tax = ClientTax.new(client_tax_params)

    respond_to do |format|
      if @client_tax.save
        format.html { redirect_to @client_tax, notice: 'Client tax was successfully created.' }
        format.json { render :show, status: :created, location: @client_tax }
      else
        format.html { render :new }
        format.json { render json: @client_tax.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_taxes/1
  # PATCH/PUT /client_taxes/1.json
  def update
    respond_to do |format|
      if @client_tax.update(client_tax_params)
        format.html { redirect_to @client_tax, notice: 'Client tax was successfully updated.' }
        format.json { render :show, status: :ok, location: @client_tax }
      else
        format.html { render :edit }
        format.json { render json: @client_tax.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_taxes/1
  # DELETE /client_taxes/1.json
  def destroy
    @client_tax.destroy
    respond_to do |format|
      format.html { redirect_to client_taxes_url, notice: 'Client tax was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_tax
      @client_tax = ClientTax.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_tax_params
      params.require(:client_tax).permit(:iva, :reteica, :retefuente, :name)
    end
end