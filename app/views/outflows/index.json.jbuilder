json.array!(@outflows) do |outflow|
  json.extract! outflow, :id, :value, :flowDate, :concept
  json.url outflow_url(outflow, format: :json)
end
