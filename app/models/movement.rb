class Movement < ActiveRecord::Base

  #validates_presence_of :consecutiveNumber, :message => "Tiene que ingresar el numero del consecutivo."
  validates_presence_of :movementDate, :message => "Tiene que ingresar la fecha del movimiento."
  validates_presence_of :value, :message => "Tiene que ingresar el valor del movimiento."
  validates_presence_of :concept, :message => "Tiene que ingresar el concepto del movimiento."

  validates :consecutiveNumber, uniqueness: { message: "Ya existe un movimiento con el mismo numero de consecutivo." },:allow_nil => true


  has_many :boxes, inverse_of: :movement

  belongs_to :logi_bill, inverse_of: :movements
  belongs_to :type_movement, inverse_of: :movements

  #---------------------------------------------
  # Dar el numero de consecutivo del movimiento
  #---------------------------------------------
  def get_consecutive_number
    consecutiveNumber ? consecutiveNumber : 'N/A'
  end

  #---------------------------------------------
  # Dar el numero de fecha del movimieto
  #---------------------------------------------
  def get_movement_date
    movementDate ? movementDate : 'N/A'
  end

  #---------------------------------------------
  # Dar el concepto del movimieto
  #---------------------------------------------
  def get_concept
    concept ? concept : 'N/A'
  end

  #---------------------------------------------
  # Dar el valor
  #---------------------------------------------
  def get_value
    value ? value : 'N/A'
  end

  #---------------------------------------------
  # Dar el valor en numero
  #---------------------------------------------
  def get_value_number
    value ? value : 0
  end

  #---------------------------------------------
  # Dar la cuenta
  #---------------------------------------------
  def get_logi_bill
    logi_bill ? logi_bill.name : 'N/A'
  end

  #---------------------------------------------
  # Dar el tipo de transaccion
  #---------------------------------------------
  def get_type_transaction
    type_movement ? type_movement.name : "N/a"
  end

  #------------------------------------------
  # Dar autor de la transaccion, si llega por
  # outflow o por movement
  #------------------------------------------
  def get_author_transaction
    if outflow then
      "Outflow: #{outflow.concept}"
    else
      movement ? "Movimiento: #{movement.concept}" : 'N/A'
    end
  end

end
