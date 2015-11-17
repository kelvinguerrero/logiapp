class Sale < ActiveRecord::Base

  #--------------------------------------------------------------
  #Modelacion many-to-many through => tabla intermedia sale,
  #Para la generacion de facturas
  #--------------------------------------------------------------
  belongs_to :outflow
  belongs_to :dispatch
  validates_presence_of :outflow, :dispatch
  validates_uniqueness_of :dispatch_id, :scope => [:outflow_id]
  #--------------------------------------------------------------

end