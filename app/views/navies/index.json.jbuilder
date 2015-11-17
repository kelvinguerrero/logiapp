json.array!(@navies) do |navy|
  json.extract! navy, :id, :name
  json.url navy_url(navy, format: :json)
end
