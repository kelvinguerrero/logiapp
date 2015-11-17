class Parameter < ActiveRecord::Base
  validates_presence_of :name, :message => "Tiene que ingresar el nombre del parametro."
  validates_presence_of :value, :message => "Tiene que ingresar el valor del parametro."


  #---------------------------------------------
  # Metodo que el nombre del parametro
  #---------------------------------------------
  def get_name_parameter
    name ? name : 'N/a'
  end

  #---------------------------------------------
  # Metodo que el valor del parametro
  #---------------------------------------------
  def get_value_parameter
    value ? value : 'N/a'
  end


end
