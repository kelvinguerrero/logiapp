json.array!(@movements) do |movement|
  json.extract! movement, :id, :movementDate, :value, :concept
  json.url movement_url(movement, format: :json)
end
