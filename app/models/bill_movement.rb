class BillMovement < ActiveRecord::Base

  has_one :previous_bill_movement, class_name: 'BillMovement', foreign_key: :bill_movement_id
  belongs_to :type_movement, inverse_of: :bill_movements
  belongs_to :logi_bill, inverse_of: :bill_movements
  belongs_to :bill_movement, inverse_of: :bill_movement

  #---------------------------------------------
  # Metodo que da el nombre del logi bill
  #---------------------------------------------
  def logi_bill_name_bill
    logi_bill ? logi_bill.name_bill : 'N/a'
  end

  #---------------------------------------------
  # Metodo que da el "Ultimo movimiento"
  #---------------------------------------------
  def get_last_change
    lastChange ? 'Si' : 'No'
  end

  #---------------------------------------------
  # Metodo que da el nombre consecutivo (id)
  # del movimiento anterior
  # En caso que no exista el movimiento anterior retorna "N/a"
  #---------------------------------------------
  def previous_bill_movement_id
    previous_bill_movement ? previous_bill_movement.id : 'N/a'
  end

  #---------------------------------------------
  # Metodo que da el nombre del tipo de movimiento
  #---------------------------------------------
  def type_name_bill
    type_movement ? type_movement.name : 'N/a'
  end

  #---------------------------------------------
  # Metodo que da el total del movimiento
  #---------------------------------------------
  def total_bill_movement
    total ? total : 'N/a'
  end

  #---------------------------------------------
  # Metodo que da el valor del movimiento
  #---------------------------------------------
  def value_bill_movement
    value ? value : 'N/a'
  end

end
