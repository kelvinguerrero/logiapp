class Assignation < ActiveRecord::Base
  validates_numericality_of :price, greater_than: 239000, :message => "El precio tiene que ser mayor a $239.000"

  validates_presence_of :shipment, :message => "Tiene que ingresar un shipment"
  validates_presence_of :quantity, :message => "Tiene que ingresar una cantidad"
  validates_presence_of :price, :message => "Tiene que ingresar un valor"
  validates_presence_of :startDate, :message => "Tiene que ingresar una fecha de inicio"
  validates_presence_of :navy_id, :message => "Tiene que ingresar una naviera"
  validates_presence_of :container_id, :message => "Tiene que ingresar un tipo de contenedor"
  validates_presence_of :way_id, :message => "Tiene que ingresar una ruta"

  validates :shipment, uniqueness: { message: "Ya existe el shipment" }
  validates :workOrder, uniqueness: { message: "Ya existe work order" },:allow_nil => true
  validates_numericality_of :quantity, :greater_than => 0


  belongs_to :navy, inverse_of: :assignations
  belongs_to :container, inverse_of: :assignations
  belongs_to :way, inverse_of: :assignations

  has_many :dispatches, inverse_of: :assignation
  has_many :invoices, inverse_of: :assignation

  def get_way_name
    way ? way.name : 'N/A'
  end

  def get_container_name
    container ? container.name : 'N/A'
  end

  def get_shipment
    shipment ? shipment : 'N/A'
  end

  def get_quantity
    quantity ? quantity : 0
  end

  def get_workOrder
    workOrder ? workOrder : 'N/A'
  end

  def get_price
    price ? price : 'N/A'
  end

  def get_startDate
    startDate ? startDate : 'N/A'
  end

  def get_endDate
    endDate ? endDate : 'N/A'
  end

  def get_navy_name
    navy ? navy.get_name_navy : 'N/A'
  end

  def get_Dispatches
    dispatches ? dispatches : 'N/A'
  end

  def get_Remaining
      get_quantity.to_i - dispatches.count
  end

  def has_Invoice
    invoices.empty?
  end

  def paid_invoices
    if invoices.empty?
      return false
    end
    invoices.each do |v_invoice|
      if not v_invoice.paid
        return false
      end
    end
    return true
  end

  def has_Dispatches
    dispatches ? true : false
  end

  def has_containers_number
    if has_Dispatches
      dispatches.each do |dispatch|
        if (not dispatch.has_container_number)
          return false
        end
      end
    else
      return false
    end
    return true
  end
end
