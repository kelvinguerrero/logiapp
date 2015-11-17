class LogiBill < ActiveRecord::Base

  validates :name, format: { with: /\A[a-zA-Z’ ñÑ']+\z/ , message: "El nombre no puede contener caracteres especiales"}
  validates_presence_of :name, :message => "Tiene que ingresar el nombre de la cuenta."
  validates_presence_of :endNumber, :message => "Tiene que ingresar los dos ultimos digitos de la cuenta."
  #validates_presence_of :total, :message => "Tiene que ingresar el total el estado de la cuenta."

  has_many :movements, inverse_of: :logi_bill
  belongs_to :box, inverse_of: :logi_bills
  has_many :bill_movements, inverse_of: :logi_bill

  #---------------------------------------------
  # Metodo que entrega el nombre del Bill
  # para mostrar
  #---------------------------------------------
  def name_bill
    "#{name}:#{endNumber}"
  end

  def get_bill_movement
    bill_movements.order("id DESC")
  end

  #---------------------------------------------
  # Metodo que entrega valot total de la cuenta
  # teniendo en cuenta el ultimo movimiento de la cuenta
  # El ultimo movimivneto de la cuenta es el que:
  # 1) no tiene movimientio anterior
  # 2) tiene el id del logibill
  #---------------------------------------------
  def get_total_bill
    movemiento = bill_movements.where(:lastChange=>true)
    movemiento.empty? ? 'N/A' : movemiento.first.total
  end

end
