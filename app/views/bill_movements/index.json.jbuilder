json.array!(@bill_movements) do |bill_movement|
  json.extract! bill_movement, :id, :total, :value
  json.url bill_movement_url(bill_movement, format: :json)
end
