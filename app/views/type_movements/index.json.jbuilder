json.array!(@type_movements) do |type_movement|
  json.extract! type_movement, :id, :name
  json.url type_movement_url(type_movement, format: :json)
end
