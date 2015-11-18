class DriverLogic
  def initialize(params)
    @params = params
  end

  def validate_car_has_driver(driver,id_carro)
    var_car_logic = CarLogic.new(@params)
    if (var_car_logic.validate_car_has_driver(id_carro))
      var_car = Car.find_by(:id=>id_carro[:id])
      driver.car = var_car
      return true
    else
      driver.add_error_car
      return false
    end
  end

  def change_status_driver(id_driver,status)

  end
end
