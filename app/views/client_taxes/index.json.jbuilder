json.array!(@client_taxes) do |client_tax|
  json.extract! client_tax, :id, :iva, :reteica, :retefuente
  json.url client_tax_url(client_tax, format: :json)
end
