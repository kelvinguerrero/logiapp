json.array!(@cars) do |car|
  json.extract! car, :id, :plate, :model, :color
  json.url car_url(car, format: :json)
end
