class Middleman < ActiveRecord::Base

  validates :name, format: { with: /\A[a-zA-Z’ ñÑ']+\z/ , message: "El nombre no puede contener caracteres especiales"}

  validates_presence_of :name, :message => "Tiene que ingresar un nombre para el comisionista"
  validates :name, uniqueness: { case_sensitive: true , message: "Ya existe una comisionista con el mismo nombre" }

  validates_presence_of :price, :message => "Tiene que ingresar el presio del comisionista"

  has_many :dispatches, inverse_of: :middleman

  #---------------------------------------------
  # Metodo que entrega el nombre del Bill
  # para mostrar
  #---------------------------------------------
  def get_name_middleman
    name ? name : 'N/a'
  end

  #---------------------------------------------
  # Metodo que entrega el nombre del Bill
  # para mostrar
  #---------------------------------------------
  def get_price_middleman
    price ? price : 'N/a'
  end

  #---------------------------------------------
  # Metodo que entrega el nombre del Bill en
  # enteros para mostrar
  #---------------------------------------------
  def get_price_middleman_entero
    price ? price : 0
  end

end
