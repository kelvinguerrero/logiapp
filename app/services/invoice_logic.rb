class InvoiceLogic

  def initialize(id_invoice)
    @p_invoice = Invoice.find_by( :id=> id_invoice )
    tax = @p_invoice.client_tax
    @iva = tax.iva ? Parameter.find_by_name('IVA').value.to_f : 0
    @reteica = tax.reteica ? Parameter.find_by_name('Reteica').value.to_f : 0
    @retefuente = tax.retefuente ? Parameter.find_by_name('Retefuente').value.to_f : 0
  end

  def pay_invoice(logibill_id)
    v_service_movement = MovementLogic.new(nil,nil)
    v_service_movement.movement_enter_logi_bill(logibill_id, @p_invoice.total)
    @p_invoice.paid=true
    @p_invoice.save
  end

  def calculate_total_invoice
    v_sub_total = 0
    @p_invoice.quantity = @p_invoice.concepts.count
    @p_invoice.concepts.each do |concepto|
      v_sub_total = v_sub_total + concepto.total
    end

    v_iva = ( v_sub_total * @iva )
    v_reteica = ( v_sub_total * @reteica )
    v_retefuente = (v_sub_total * @retefuente )
    v_total = v_sub_total + v_iva + v_retefuente + v_reteica

    @p_invoice.total = v_total
    @p_invoice.subtotal = v_sub_total
    @p_invoice.iva = v_iva
    @p_invoice.retefuente = v_retefuente
    @p_invoice.reteica = v_reteica
    @p_invoice.save

    rta_hash = Hash.new
    if @p_invoice.valid?
      @p_invoice.save
      rta_hash["rta"]=true
      return rta_hash
    else
      rta_hash["error"]=p_invoice
      rta_hash["rta"]=false
      return rta_hash
    end

  end
end