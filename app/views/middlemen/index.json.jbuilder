json.array!(@middlemen) do |middleman|
  json.extract! middleman, :id, :name, :price
  json.url middleman_url(middleman, format: :json)
end
