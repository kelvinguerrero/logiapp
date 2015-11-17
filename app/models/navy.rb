class Navy < ActiveRecord::Base

  validates :name, format: { with: /\A[a-zA-Z’ ñÑ']+\z/ , message: "El nombre no puede contener caracteres especiales"}
  validates_presence_of :name, :message => "Tiene que ingresar un nombre"
  validates :name, uniqueness: { case_sensitive: true , message: "Ya existe una naviera con el mismo nombre" }


  has_many :assignations, inverse_of: :navy

  #---------------------------------------------
  # Metodo que entrega el nombre de la naviera
  #---------------------------------------------
  def get_name_navy
    name ? name : 'N/A'
  end
end