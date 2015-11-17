json.array!(@drivers) do |driver|
  json.extract! driver, :id, :name, :lastName, :document, :cellphone
  json.url driver_url(driver, format: :json)
end
