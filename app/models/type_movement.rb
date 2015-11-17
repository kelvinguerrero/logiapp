class TypeMovement < ActiveRecord::Base
  validates_presence_of :name, :message => "Tiene que ingresar un nombre para el tipo"

  has_many :movements, inverse_of: :type_movement
  has_many :bill_movements, inverse_of: :type_movement

  def get_name
    name ? name : 'N/A'
  end
end
