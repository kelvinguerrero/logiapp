json.array!(@boxes) do |box|
  json.extract! box, :id, :name, :value, :total, :incomeDate
  json.url box_url(box, format: :json)
end
