namespace :loader do

  desc "Cargue de la base"
  task load_base: :environment do
    p "Inicio Cargue de la base"
    Rake::Task['loader:load_parametros'].invoke
    Rake::Task['load_client_taxes'].invoke
    Rake::Task['loader:load_type'].invoke
  end

  desc "Cargue de la base prueba"
  task load_base_mokup: :environment do
    require 'populator'
    [Assignation, Box, Driver, Car, ClientTax, Container, Dispatch, Invoice,
     LogiBill, Middleman, Movement, Navy, Outflow, Parameter, Sale, TypeMovement, Way].each(&:delete_all)

    p "Inicio Cargue de la base"
    Rake::Task['loader:load_parametros'].invoke
    Rake::Task['loader:load_client_taxes'].invoke
    Rake::Task['loader:load_rutas'].invoke
    Rake::Task['loader:load_type'].invoke
    Rake::Task['loader:load_bills'].invoke
    Rake::Task['loader:load_naviera'].invoke
    Rake::Task['loader:load_contenedor'].invoke
    Rake::Task['loader:load_asignacion'].invoke
    Rake::Task['loader:load_conductor_carro'].invoke
    Rake::Task['loader:load_comisionista'].invoke
    Rake::Task['loader:load_despacho'].invoke
  end


  desc "Cargue de los parametros"
  task load_parametros: :environment do
    p 'Cargue de parametros'
    attributes1 = {'name' => 'cantidad_dias_vias', 'value' => '8'}
    Parameter.create(attributes1)

    attributes2 = {'name' => 'cantidad_dia_maximo', 'value' => '1'}
    Parameter.create(attributes2)

    attributes3 = {'name' => 'cantidad_dia_factura', 'value' => '30'}
    Parameter.create(attributes3)

    attributes4 = {'name' => 'Entrada', 'value' => 'entrada'}
    Parameter.create(attributes4)

    attributes5 = {'name' => 'Salida', 'value' => 'salida'}
    Parameter.create(attributes5)

    attributes6 = {'name' => 'max_contenedores_factura', 'value' => '20'}
    Parameter.create(attributes6)

    attributes7 = {'name' => 'contenedor_20', 'value' => '240000'}
    Parameter.create(attributes7)

    attributes8 = {'name' => 'contenedor_40', 'value' => '480000'}
    Parameter.create(attributes8)

    attributes9 = {'name' => 'IVA', 'value' => '0.16'}
    Parameter.create(attributes9)

    attributes10 = {'name' => 'Reteica', 'value' => '0.00966'}
    Parameter.create(attributes10)

    attributes11 = {'name' => 'Retefuente', 'value' => '0.04'}
    Parameter.create(attributes11)

    attributes12 = {'name' => 'sale_advance', 'value' => '0'}
    Parameter.create(attributes12)

    attributes13 = {'name' => 'sale_balance', 'value' => '1'}
    Parameter.create(attributes13)

    attributes14 = {'name' => 'sale_advance_correction', 'value' => '2'}
    Parameter.create(attributes14)

    attributes15 = {'name' => 'sale_balance_correction', 'value' => '3'}
    Parameter.create(attributes15)
  end


  desc 'Cargue de tipos de transacciones'
  task  load_type: :environment do
    p 'cargue de tipos de transacciones'
    attributes = {'name' => Parameter.find_by_name('Entrada').name}
    TypeMovement.create(attributes)
    attributes = {'name' => Parameter.find_by_name('Salida').name}
    TypeMovement.create(attributes)
  end


  desc "Cargue de cliente taxes"
  task load_client_taxes: :environment do
    attributes1 = {'iva'=>false, 'reteica'=>false, 'retefuente'=>false, 'name'=>'Maersk'}
    ClientTax.create(attributes1)

    attributes2 = {'iva'=>false, 'reteica'=>false, 'retefuente'=>false, 'name'=>'Hapa'}
    ClientTax.create(attributes2)

    attributes3 = {'iva'=>true, 'reteica'=>true, 'retefuente'=>true, 'name'=>'Transcomerinter'}
    ClientTax.create(attributes3)

    attributes4 = {'iva'=>true, 'reteica'=>false, 'retefuente'=>true, 'name'=>'Coordicargas'}
    ClientTax.create(attributes4)
  end

  desc 'Loader Rutas'
  task  load_rutas: :environment do
    p 'Cargue rutas'
    attributes = {'name' => 'Medellin/Bbtura'}
    Way.create(attributes)
    attributes = {'name' => 'Bogotá/Bbtura'}
    Way.create(attributes)
    end

  desc 'Loader Bills'
  task  load_bills: :environment do
    p 'Cargue cuentas'

    attributes = {'name' => 'B Colombia', 'endNumber' =>23}
    lb = LogiBill.create(attributes)
    v_type = TypeMovement.find_by(:name=>'Entrada')
    attributes_movement = {'logi_bill_id' => lb.id,'bill_movement_id'=>nil, 'total' =>5000000, 'value'=>5000000,:type_movement_id=>v_type.id}
    BillMovement.create(attributes_movement)

    attributes1 = {'name' => 'B Colombia', 'endNumber' =>24}
    lb2=LogiBill.create(attributes1)
    attributes_movement = {'logi_bill_id' => lb2.id,'bill_movement_id'=>nil, 'total' =>4000000, 'value'=>4000000,:type_movement_id=>v_type.id}
    BillMovement.create(attributes_movement)
  end

  desc 'Loader Naviera'
  task  load_naviera: :environment do
    p 'Cargue Naviera'
    attributes = {'name' => 'Maersk'}
    Navy.create(attributes)
    attributes = {'name' => 'Hapa'}
    Navy.create(attributes)
  end

  desc 'Loader Contenedor'
  task  load_contenedor: :environment do
    p 'Cargue contenedor'
    attributes = {'name' => '20 standar'}
    Container.create(attributes)
    attributes1 = {'name' => '20 HQ'}
    Container.create(attributes1)
    attributes2 = {'name' => '40 standar'}
    Container.create(attributes2)
    attributes3 = {'name' => '40 HQ'}
    Container.create(attributes3)
    attributes4 = {'name' => 'Otro'}
    Container.create(attributes4)
  end

  desc 'Loader Asignación'
  task  load_asignacion: :environment do
    p 'Cargue asignación'
    attributes = {'endDate' => Date.parse("2014-2-15"), 'price' => 480000, 'quantity' => 2, 'shipment' => '2102938470',
                  'startDate' => Date.parse("2014-2-1"), 'workOrder'=> '1123450',
                  'navy_id' => Navy.first.id , 'container_id' => Container.second.id, 'way_id'=>Way.first.id}
    Assignation.create(attributes)

    attributes1 = {'endDate' => Date.parse("2014-2-15"), 'price' => 480000, 'quantity' => 20, 'shipment' => '2102938471',
                  'startDate' => Date.parse("2014-2-1"), 'workOrder'=> '1123451',
                  'navy_id' => Navy.second.id , 'container_id' => Container.third.id, 'way_id'=>Way.second.id}
    Assignation.create(attributes1)
    attributes2 = {'endDate' => Date.parse("2014-2-15"), 'price' => 480000, 'quantity' => 3, 'shipment' => '2102938472',
                  'startDate' => Date.parse("2014-2-1"), 'workOrder'=> '1123452',
                  'navy_id' => Navy.first.id , 'container_id' => Container.first.id, 'way_id'=>Way.first}
    Assignation.create(attributes2)
  end

  desc 'Loader Conductor'
  task  load_conductor_carro: :environment do
    p 'Cargue conductor'
    Driver.populate 100 do |conductor|
      conductor.name = Faker::Name.name
      conductor.lastName = Faker::Name.name
      conductor.document = Faker::Code.ean
      conductor.cellPhone = Faker::Number.number(10)
      conductor.busy = false
      conductor.blacklist = false
      Car.populate 1 do |car|
        car.driver_id = conductor.id
        car.plate = "#{Faker::Lorem.characters(3)} #{Faker::Number.number(3)}"
        car.color = Faker::Commerce.color
        car.model = "#{rand(1990..2014)}"
      end
    end
  end

  desc 'Loader comisionista'
  task  load_comisionista: :environment do
    p 'Cargue comisionista'
    attributes = {'name' => 'Guillermo', 'price' => 20000}
    Middleman.create(attributes)

    attributes1 = {'name' => 'Nicolar', 'price' => 20000}
    Middleman.create(attributes1)

    attributes2 = {'name' => 'Amanda', 'price' => 20000}
    Middleman.create(attributes2)

  end

  desc 'Loader Despacho'
  task  load_despacho: :environment do
    p 'Cargue despacho'

    asignacion1 = Assignation.first
    asignacion1.quantity = asignacion1.quantity - 1
    attributes = {'manifestNumber' => 222220, 'loadOrder' => 333330, 'advance' => 324000,
                  'balance' => 44000, 'assignation_id' => asignacion1.id, 'middleman_id' => Middleman.first.id ,
                  'driver_id' => Driver.first.id, 'car_id'=> Car.first.id}
    Dispatch.create(attributes)
    asignacion1.save

    asignacion2 = Assignation.second
    asignacion2.quantity = asignacion2.quantity - 1
    attributes2 = {'manifestNumber' => 222221, 'loadOrder' => 333331, 'advance' => 324000,
                  'balance' => 44000, 'assignation_id' => asignacion2.id, 'middleman_id' => Middleman.second.id ,
                  'driver_id' => Driver.second.id, 'car_id'=> Car.second.id}
    Dispatch.create(attributes2)
    asignacion2.save

    asignacion3 = Assignation.second
    asignacion3.quantity = asignacion3.quantity - 1
    attributes3 = {'manifestNumber' => 222222, 'loadOrder' => 333332, 'advance' => 'rojo',
                  'balance' => Driver.first.id, 'assignation_id' => asignacion3.id, 'middleman_id' => Middleman.third.id ,
                  'driver_id' => Driver.second.id, 'car_id'=> Car.third.id}
    Dispatch.create(attributes3)
  end

end