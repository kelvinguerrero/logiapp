class Invoice < ActiveRecord::Base

  validates_presence_of :total, :message => "Tiene que ingresar un total"
  validates_presence_of :subtotal, :message => "Tiene que ingresar el sub total"
  validates_presence_of :iva, :message => "Tiene que ingresar el iva"
  validates_presence_of :retefuente, :message => "Tiene que ingresar la retefuente"
  validates_presence_of :reteica, :message => "Tiene que ingresar un el tere ica"

  validates :workorder, presence: { :message => "Tiene que ingresar una work Order" }, if: :assignation_not_nulo?
  validates :quantity, presence: { :message => "Tiene que ingresar la cantidad de contenedores a facturar" }, if: :assignation_not_nulo?

  def assignation_not_nulo?
    not assignation.nil?
  end

  validates_presence_of :expirationDate, :message => "Tiene que ingresar la fecha de vencimiento de la factura"
  validates_presence_of :elaborationDate, :message => "Tiene que ingresar la fecha de elavoración de la factura"

  belongs_to :client_tax, inverse_of: :invoices
  belongs_to :assignation, inverse_of: :invoices

  has_many :dispatches, inverse_of: :invoice
  has_many :concepts, dependent: :destroy, inverse_of: :invoice

  accepts_nested_attributes_for :concepts, allow_destroy: true


  def get_assig_navy_name_invoice
    assignation ? assignation.get_navy_name : 'N/A'
  end

  def get_assig_shipment_invoice
    assignation ? assignation.shipment : 'N/A'
  end

  def get_quantity_invoice
    quantity ? quantity : 'N/A'
  end

  def get_total_invoice
    total ? total : 0
  end


  def get_subtotal_invoice
    subtotal ? subtotal : 0
  end

  def get_iva_invoice
    iva ? iva : 0
  end

  def get_retefuente_invoice
    retefuente ? retefuente : 0
  end

  def get_reteica_invoice
    reteica ? reteica : 0
  end

  def get_paid_invoice
    paid
  end

  def get_idcontable_invoice
    idcontable ? idcontable : 'N/A'
  end

  def get_expiration_date_invoice
    expirationDate ? expirationDate : 'N/A'
  end

  def get_elaboration_date_invoice
    elaborationDate ? elaborationDate : 'N/A'
  end

  def get_eradicate_date_invoice
    eradicateDate ? eradicateDate : 'N/A'
  end

  def get_client_tax_invoice
    client_tax ? client_tax : 'N/A'
  end

  #------------------------------------------
  #Work Order
  #------------------------------------------
  def get_work_order_invoice
    workorder ? workorder : 'N/A'
  end

end