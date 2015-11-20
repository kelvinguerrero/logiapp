class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  # GET /pay
  def pay
    @invoice = Invoice.find(params[:invoice_id])
    service_invoice = InvoiceLogic.new(@invoice.id)
    service_invoice.pay_invoice(params[:logi_bill_id])
    respond_to do |format|
      format.html { redirect_to @invoice, notice: 'La factura esta pága.' }
    end
  end

  # GET /listinvoice
  def listinvoice
    asignacion = Assignation.find_by(:id =>params[:p_assignation_id])
    @lits_invoices = asignacion.invoices
  end

  # GET /preinvoice
  def preinvoice
    asignacion = Assignation.find_by(:id =>params[:p_assignation_id])
    if asignacion.has_containers_number
      if (not params[:workorder_number].empty?) or (params[:workorder_number].to_s.length > 0)
        if asignacion.invoices.empty?
          account = AccountancyLogic.new(params)
          rta_hash = account.invoice_containers_navy(params[:workorder_number])
          if rta_hash["rta"] != false
            @lits_invoices = asignacion.invoices
          else
            @errores = rta_hash["error"]
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to @invoice, notice: 'No se puede genera la factura sin Work Order.' }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to asignacion, notice: 'No se genero la factura, existen despachos sin número de contenedor.' }
      end
    end
  end

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice.all
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'La factura fue creada correctamente.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        invoice_logic = InvoiceLogic.new(@invoice.id)
        invoice_logic.calculate_total_invoice

        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private

    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:total, :quantity, :expirationDate, :elaborationDate,
                                      :eradicateDate, :idcontable, :subtotal, :iva,
                                      :retefuente, :reteica, :paid,
                                      concepts_attributes:[:id,:container,:description,:route,:total,:_destroy])
    end
end
