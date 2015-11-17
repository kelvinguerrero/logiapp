class Container < ActiveRecord::Base
  validates_presence_of :name, :message => "Tiene que ingresar un nombre del tipo de contenedor"
  validates :name, uniqueness: { case_sensitive: true , message: "Ya existe un contenedor con el mismo nombre" }


  has_many :assignations, inverse_of: :container

  def get_name_container
    name ? name : 'N/A'
  end

end
