json.array!(@assignations) do |assignation|
  json.extract! assignation, :id, :shipment, :quantity, :workorder, :startdate, :enddate
  json.url assignation_url(assignation, format: :json)
end
