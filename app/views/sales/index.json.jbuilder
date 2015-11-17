json.array!(@sales) do |sale|
  json.extract! sale, :id, :description, :type
  json.url sale_url(sale, format: :json)
end
