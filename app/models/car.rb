class Car < ActiveRecord::Base

  validates :plate, format: { with: /\A([a-zA-Z]{3}\d{3})\Z/i , message: "La placa debe ser valida Ej.( ABC123 )"}

  validates_presence_of :plate, :message => "Tiene que ingresar la placa del carro."
  validates_presence_of :model, :message => "Tiene que ingresar el modelo del carro."
  validates_presence_of :color, :message => "Tiene que ingresar el color del carro."

  validates :plate, uniqueness: { message: "Ya existe un carro con el la misma placa." }

  belongs_to :driver, inverse_of: :car
  has_many :dispatches, inverse_of: :car

  def get_plate_car
    plate ? plate : 'N/A'
  end

  def get_model_car
    model ? model : 'N/A'
  end

  def get_color_car
    color ? color : 'N/A'
  end
end
