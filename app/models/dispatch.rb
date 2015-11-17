class Dispatch < ActiveRecord::Base

  validates_presence_of :assignation_id, :message => "Tiene que ingresar un shipment de una asignacion."
  validates_presence_of :driver_id, :message => "Tiene que ingresar un conductor."
  validates_presence_of :car_id, :message => "Tiene que ingresar un carro."
  validates_presence_of :deliverDate, :message => "Tiene que la fecha de cargue."


  validate :validation_dispatch_available_assignation, :validation_dispatch_driver,
           :validation_loadOrder, :validation_containerNumber, :validation_manifestNumber,
           :validation_balance, :validation_balance_disposition, :validation_advance_disposition

  belongs_to :assignation, inverse_of: :dispatches
  belongs_to :car, inverse_of: :dispatches
  belongs_to :driver, inverse_of: :dispatches
  belongs_to :middleman, inverse_of: :dispatches

  belongs_to :invoice, inverse_of: :dispatches

  #--------------------------------------------------------------
  #Modelacion many-to-many through => tabla intermedia sale,
  #Para la generacion de facturas
  #--------------------------------------------------------------
  has_many :sales, inverse_of: :dispatch, dependent: :destroy
  has_many :outflows,-> { distinct }, through: :sales
  #--------------------------------------------------------------

  #---------------------------------------------------------------------------------------------
  # Validacion de pago de anticipo, no se puede ingresar el anticipo si no se tiene dinero en la caja.
  #---------------------------------------------------------------------------------------------
  def validation_advance_disposition
    last_box = Box.last
    if last_box
      if advance and advance > last_box.total

        errors.add(:advance, ": No se puede pagar el anticipo, pues no en la caja quedan $#{last_box.total }.")
      end
    else
      errors.add(:advance, ": No se puede registrar el anticipo, pues no existe valores en la caja.")
    end
  end

  #---------------------------------------------------------------------------------------------
  # Validacion de pago de salgo, no se puede ingresar el saldo si no se tiene dinero en la caja.
  #---------------------------------------------------------------------------------------------
  def validation_balance_disposition
    last_box = Box.last
    if last_box
      if balance and balance > last_box.total

        errors.add(:balance, ": No se puede pagar el saldo, pues no en la caja quedan $#{last_box.total }.")
      end
    else
      errors.add(:balance, ": No se puede registrar el saldo, pues no existe valores en la caja.")
    end
  end


  #---------------------------------------------------------------------------------------------
  # Validacion de pago de salgo, no se puede parar el saldo porque se demoro mas de 15 días en
  # la entrega del contenedor.
  # No se puede pagar el saldo sin registrar el anticipo la fecha de descargue,
  # fecha de anticipo, fecha de saldo o fecha de cumplido.
  #---------------------------------------------------------------------------------------------
  def validation_balance
    if (advance.nil? or downloadDate.nil? or advanceDate.nil? or paymentBalanceDate.nil? or completeDate.nil? or status_amarillo) and balance
      if status_amarillo
        errors.add(:balance, ": No se puede registrar el saldo porque se demoro mas de 15 dias en la entrega del contenedor.")
      else
        errors.add(:balance, ": No se puede registrar el saldo sin registrar el anticipo, la fecha de descargue, fecha de anticipo, fecha de saldo o fecha de cumplido.")
      end
    end
  end

  #---------------------------------------------------------------------------------------------
  # Validacion de despacho en donde no se puede generar el manifiesto si no existe el
  # número de contenedor
  #---------------------------------------------------------------------------------------------
  def validation_manifestNumber
    if (containerNumber.to_s.length == 0 or containerNumber.nil?) and manifestNumber
      errors.add(:manifestNumber, ": No se puede generar el manifiesto si no existe el numero de contenedor.")
    end
  end


  #---------------------------------------------------------------------------------------------
  # Validacion de despacho en donde no se puede agregar numero de contenedor sin existir numero
  # de orden de cargue
  #---------------------------------------------------------------------------------------------
  def validation_containerNumber
    if (loadOrder.nil?) and (containerNumber.length > 0)
      errors.add(:containerNumber, ": No se puede generar el numero de contenedor si no existe el numero de orden de cargue.")
    end
  end

  #---------------------------------------------------------------------------------------------
  # Validacion de despacho en donde no se puede agergar orden de cargue sin existir conductor,
  # la placa del carro, fecha de cargue o concepto de cargue
  #---------------------------------------------------------------------------------------------
  def validation_loadOrder
    if ( (not driver_id) or (not car_id) or ( not deliverDate) or ( unoccupied ? false : (loadConcept.nil? or (loadConcept.length == 0))))
      errors.add(:loadOrder, ": No se puede generar el numero de orden de cargue sin existir un conductor, la placa del carro, fecha de cargue o concepto de cargue.")
    end
  end

  #------------------------------------------
  # Validacion de despacho cuando no se tienen mas
  # contenedores para despachar por asignación
  #------------------------------------------
  def validation_dispatch_available_assignation
    begin
      if assignation.get_Remaining < 1 and self.id.nil?
        errors.add(:assignation_id, ": No se puede crear una nueva orden de cargue, la asignacion #{ assignation.shipment } no tiene mas contenedores para despachar.")
      end
    rescue
      p "Error no entro a la validacion de creacion de obra"
    end
  end

  #------------------------------------------
  # validacion de despacho de conductor
  #------------------------------------------
  def validation_dispatch_driver
    if driver_id.nil?
      errors.add(:driver_id, ": No se puede crear una nueva orden de cargue, sin un conductor.")
    end
  end

  #------------------------------------------
  # Dar Tipo de contenedor
  #------------------------------------------
  def get_assignation_way
    assignation ? assignation.get_way_name : 'N/A'
  end

  #------------------------------------------
  # Dar Tipo de contenedor
  #------------------------------------------
  def get_container_name
    assignation ? assignation.get_container_name : 'N/A'
  end

  #------------------------------------------
  # Dar shipment
  #------------------------------------------
  def get_assignation_shipment
    assignation ? assignation.shipment : 'N/A'
  end

  #------------------------------------------
  # Dar nombre del comisionista
  #------------------------------------------
  def get_middleman
    middleman ? middleman.name : 'N/A'
  end

  #------------------------------------------
  # Dar Nombre del conductor
  #------------------------------------------
  def get_driver_name
    driver ? driver.name : 'N/A'
  end

  #------------------------------------------
  # Dar apellido del conductor
  #------------------------------------------
  def get_driver_last_name
    driver ? driver.lastName : 'N/A'
  end

  #------------------------------------------
  # Dar celular del conductor
  #------------------------------------------
  def get_driver_cellPhone
    driver ? driver.cellPhone : 'N/A'
  end

  #------------------------------------------
  # Dar documento del conductor
  #------------------------------------------
  def get_driver_document
    driver ? driver.document : 'N/A'
  end

  #------------------------------------------
  # Dar total de despachos del conductor
  #------------------------------------------
  def get_driver_dispatches_count
    driver and driver.dispatches ? driver.dispatches.count : 0
  end

  #------------------------------------------
  # Dar placa del carro del despacho
  #------------------------------------------
  def get_car_plate
    car ? car.plate : 'N/A'
  end

  #------------------------------------------
  # Dar color del carro del despacho
  #------------------------------------------
  def get_car_color
    car ? car.color : 'N/A'
  end

  #------------------------------------------
  # Dar model del carro del despacho
  #------------------------------------------
  def get_car_model
    car ? car.model : 'N/A'
  end

  #------------------------------------------
  # Dar Saldo
  #------------------------------------------
  def get_balance
    balance ? balance : 0
  end

  #------------------------------------------
  # Dar anticipo
  #------------------------------------------
  def get_advance
    advance ? advance : 0
  end

  #------------------------------------------
  #Numero de manifiesto
  #------------------------------------------
  def get_manifest_number
    manifestNumber ? manifestNumber : 0
  end

  #------------------------------------------
  #Fecha de entrega de orden de carga
  #------------------------------------------
  def get_cargue_date
    deliverDate ? deliverDate : 'N/A'
  end

  #------------------------------------------
  #Fecha de descargue en sociedad portuaria
  #------------------------------------------
  def get_download_date
    downloadDate ? downloadDate : 'N/A'
  end

  #------------------------------------------
  #Fecha de entrega de anticipo
  #------------------------------------------
  def get_advance_date
    advanceDate ? advanceDate : 'N/A'
  end

  #------------------------------------------
  #Fecha de pago de saldo
  #------------------------------------------
  def get_payment_balance_date
    paymentBalanceDate ? paymentBalanceDate : 'N/A'
  end

  #------------------------------------------
  # Fecha de cumplido
  #------------------------------------------
  def get_complete_date
    completeDate ? completeDate : 'N/A'
  end

  #------------------------------------------
  #Boleano informa si se paga o no el saldo
  #------------------------------------------
  def get_balance_pay
    balancePay ? balancePay : 'N/A'
  end

  #------------------------------------------
  #Concepto de cargue
  #------------------------------------------
  def get_loadConcept
    loadConcept ? loadConcept : 'N/A'
  end

  #------------------------------------------
  #se va el contenedor vacio
  #------------------------------------------
  def get_unoccupied
    unoccupied ? unoccupied : 'N/A'
  end

  #------------------------------------------
  #Numero de contenedor
  #------------------------------------------
  def get_container_number
    (containerNumber and (not containerNumber=="") ) ? containerNumber : 'N/A'
  end

  #------------------------------------------
  #Tiene de contenedor
  #------------------------------------------
  def has_container_number
    (containerNumber and (not containerNumber=="") ) ? true : false
  end

  #------------------------------------------
  #Nombre y apellido de conductor
  #------------------------------------------
  def get_driver_name_complete
    driver ? driver.name + ' ' + driver.lastName : 'N/A'
  end

  #------------------------------------------
  # Numero de documento del conductor
  #------------------------------------------
  def get_driver_document
    driver ? driver.document : 'N/A'
  end

  #------------------------------------------
  # Orden de cargue
  #------------------------------------------
  def get_load_order
    loadOrder ? loadOrder : 'N/A'
  end


  #------------------------------------------
  # Dar work order
  #------------------------------------------
  def get_work_order
    invoice ? invoice.get_work_order_invoice : 'N/A'
  end


  #------------------------------------------
  # Estado no pago saldo
  #------------------------------------------
  def status_amarillo
    if deliverDate and downloadDate
      if (downloadDate - deliverDate).to_i > 15
        return true
      end
    end
    return false
  end

  #------------------------------------------
  # Estado demorado en la entrega del contenedor
  #------------------------------------------
  def status_rojo
      if not downloadDate
        if deliverDate
          if (Date.today - deliverDate).to_i > 8
            return true
          end
        end
      end
      return false
  end

  #------------------------------------------
  # Estado cumplido del contenedor sin saldo
  #------------------------------------------
  def status_azul
    if deliverDate and (not(paymentBalanceDate))
      if (downloadDate and deliverDate)
        if ((downloadDate - deliverDate).to_i < 15)
          return true
        end
      end
    end
    return false
  end

  #------------------------------------------
  # Estado entregado con satisfaccion
  # pagado correctamente
  #------------------------------------------
  def status_verde
    if (get_payment_balance_date)
      return true
    end
  end

end
