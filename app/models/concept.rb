class Concept < ActiveRecord::Base

  validates_presence_of :container, :message => "Concepto: Tiene que ingresar un número de contenedor."
  validates_presence_of :description, :message => "Concepto: Tiene que ingresar una descripción."
  validates_presence_of :route, :message => "Concepto: Tiene que ingresar una ruta."
  validates_presence_of :total, :message => "Concepto: Tiene que ingresar un totál."


  belongs_to :invoice, inverse_of: :concepts

  def get_invoice_id
    invoice ? invoice_id : 'N/A'
  end

  def get_container
    container ? container : 'N/A'
  end

  def get_description
    description ? description : 'N/A'
  end

  def get_route
    route ? route : 'N/A'
  end

  def get_total
    total ? total : 'N/A'
  end

end
