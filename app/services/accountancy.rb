class Accountancy

  def initialize(params)
    @params = params
    @val_contenedor_20 = Parameter.find_by_name('contenedor_20').value.to_f
    @val_contenedor_40 = Parameter.find_by_name('contenedor_40').value.to_f
    @id_assignation = @params[:p_assignation_id]
    @asignacion = Assignation.find_by(:id=>@id_assignation)

  end

  def invoice_containers_navy(p_work_order)
    despachos = @asignacion.dispatches
    tot_contenedores = Parameter.find_by_name('max_contenedores_factura').value.to_i

    cantidad = calcular_cantidad_facturas(@asignacion.dispatches.count, tot_contenedores)

    j = Hash.new
    (1..cantidad).each do |i|
      j = j.merge(i=>{})
    end

    contenedores_contador = 0
    factura = 1

    despachos.each do |despacho|
      if contenedores_contador < tot_contenedores
        j[factura] = j[factura].merge(despacho.id => {"contenedor"=>despacho.containerNumber,
                                                      "descripcion"=>@asignacion.get_container_name,
                                                      "origenDestino"=>@asignacion.get_way_name})
        contenedores_contador = contenedores_contador +1
      else
        factura = factura + 1
        j[factura] = j[factura].merge(despacho.id => {"contenedor"=>despacho.containerNumber,
                                                      "descripcion"=>@asignacion.get_container_name,
                                                      "origenDestino"=>@asignacion.get_way_name})
        contenedores_contador = 1
      end
    end

    j.each do |key,value|
      rta = generar_factura(value,p_work_order)
      if rta["rta"] == false
        return rta
      end
    end

  end

  def calcular_cantidad_facturas(tot_despachos, max_contenedores)
    total_division = (tot_despachos / max_contenedores.to_f).ceil
    total_division
  end

  def generar_factura(contenedores,p_work_order)

    cliente = @asignacion.navy.name
    tax = ClientTax.find_by_name(cliente)

    v_elaboration_date = Date.today
    v_cantidad_dia_factura = Date.today + Parameter.find_by_name('cantidad_dia_factura').value.to_i

    p_invoice = Invoice.create(:assignation_id=>@id_assignation,
                               :elaborationDate => v_elaboration_date,
                               :expirationDate => v_cantidad_dia_factura,
                               :quantity => contenedores.count,
                               :total => 0,
                               :subtotal => 0,
                               :iva => 0,
                               :retefuente => 0,
                               :reteica => 0,
                               :workorder => p_work_order,
                               :client_tax=>tax )
    p_invoice.save

    contenedores.each do |key,value|
      p_dispatch = Dispatch.find_by(:id => key)
      tipo_contenedor = p_dispatch.assignation.container.name
      price = p_dispatch.assignation.price
      if '20 HQ' == tipo_contenedor || '20 standar' == tipo_contenedor
        v_concepto = Concept.create(:container => value['contenedor'],
                                    :description=> value['descripcion'],
                                    :route=> value['origenDestino'],
                                    :total=>price,
                                    :invoice=>p_invoice)
        v_concepto.save
      else
        v_concepto = Concept.create(:container => value['contenedor'],
                                    :description=> value['descripcion'],
                                    :route=> value['origenDestino'],
                                    :total=>price,
                                    :invoice=>p_invoice)
        v_concepto.save
      end

      p_dispatch.invoice=p_invoice
      p_dispatch.save
    end

    invoice_logic = InvoiceLogic.new(p_invoice.id)
    return invoice_logic.calculate_total_invoice

  end

end