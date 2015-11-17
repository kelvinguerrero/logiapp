class Outflow < ActiveRecord::Base
  validates_presence_of :value, :message => "Tiene que ingresar el valor del flujo."
  validates_presence_of :flowDate, :message => "Tiene que ingresar la fecha del flujo."
  validates_presence_of :concept, :message => "Tiene que ingresar el concepto del flujo."

  has_many :boxes, inverse_of: :outflow

  #--------------------------------------------------------------
  #Modelacion many-to-many through => tabla intermedia sale,
  #Para la generacion de facturas
  #--------------------------------------------------------------
  has_many :sales, inverse_of: :outflow, dependent: :destroy
  has_many :dispatches, -> { distinct }, through: :sales, dependent: :destroy
  #--------------------------------------------------------------}

  #---------------------------------------------
  # Metodo que entrega el valor del flujo
  #---------------------------------------------
  def get_value_outflow
    value ? value : 'N/A'
  end

  #---------------------------------------------
  # Metodo que entrega el valor en numeros del
  # flujo
  #---------------------------------------------
  def get_value_navy_number_outflow
    value ? value : 0
  end

  #---------------------------------------------
  # Metodo que entrega la fecha del flujo
  #---------------------------------------------
  def get_flow_date_outflow
    flowDate ? flowDate : 'N/A'
  end

  #---------------------------------------------
  # Metodo que entrega el concepto del flujo
  #---------------------------------------------
  def get_concept_outflow
    concept ? concept : 'N/A'
  end



end