module ApplicationHelper
  #-------------------------------------------------------------------------------------------------------------
  # Amarillo: existe fecha de entrega de contenedor Y
  #           no existe fecha de pago de saldo Y
  #           la resta de los dias entre la fecha de entrega de contenendor y fecha de desacargue es menos a 15
  #
  # Rojo: No existe fecha de desacargue Y
  #       la resta entre el la fecha actual menos la fecha de cargue es menor a 8
  #
  # Azul: Fecha de descarque menos la fecha de cargue es menos a 15
  #
  # Verde: Si existe fecha de pago de salgo.
  #-------------------------------------------------------------------------------------------------------------
  def status_assignation(dispatch)
    if dispatch.status_rojo
      'class="danger"'.html_safe
    elsif dispatch.status_amarillo
      'class="warning"'.html_safe
    elsif dispatch.status_azul
      'class="info"'.html_safe
    elsif dispatch.status_verde
      'class="success"'.html_safe
    end
  end

  #--------------------------
  # Metodo para agregar datos en el invoice
  #--------------------------
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_partial", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
