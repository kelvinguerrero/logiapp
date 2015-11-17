class Way < ActiveRecord::Base
  validates_presence_of :name, :message => "Tiene que ingresar un nombre para la ruta"
  validates :name, uniqueness: { case_sensitive: true , message: "Ya existe una ruta con el mismo nombre" }

  has_many :assignations, inverse_of: :way

  def get_name
    name ? name : 'N/A'
  end
end
