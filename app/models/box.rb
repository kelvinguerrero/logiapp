class Box < ActiveRecord::Base
  validates_presence_of :value, :message => "Tiene que existir el valor de la trasanccion."
  validates_presence_of :total, :message => "Tiene que ingresar el total de la caja."
  validates_presence_of :incomeDate, :message => "Tiene que ingresar la fecha de la transacción."


  belongs_to  :movement, inverse_of: :boxes
  belongs_to :outflow, inverse_of: :boxes
  has_many :logi_bills, inverse_of: :box



  #---------------------------------------------
  # Metodo que da el nombre
  #---------------------------------------------
  def get_name_box
    name ? name : 'N/a'
  end

  #---------------------------------------------
  # Metodo que da el valor
  #---------------------------------------------
  def get_value_box
    value ? value : 'N/a'
  end

  #---------------------------------------------
  # Metodo que da el valor en numeros
  #---------------------------------------------
  def get_value_box_number
    value ? value : 0
  end

  #---------------------------------------------
  # Metodo que da el total
  #---------------------------------------------
  def get_total_box
    total ? total : 'N/a'
  end
  #---------------------------------------------
  # Metodo que da el total en numeros
  #---------------------------------------------
  def get_total_box_number
    total ? total : 0
  end

  #---------------------------------------------
  # Metodo que da la fecha
  #---------------------------------------------
  def get_incomeDate_box
    incomeDate ? incomeDate : 'N/a'
  end

  #------------------------------------------
  # Dar autor de la transaccion, si llega por
  # outflow o por movement
  #------------------------------------------
  def get_author_transaction
    if outflow then
      "Outflow: #{outflow.concept}"
    else
      movement ? "Movimiento: #{movement.get_type_transaction}" : 'N/A'
    end
  end


end