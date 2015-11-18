class CarLogic
  def initialize(params)
    @params = params
  end

  def validate_car_has_driver(id_car)
     c = Car.find_by(:id=>id_car[:id])
     return c.driver.nil?
  end

  def change_status_driver(id_driver,status)

  end
end
