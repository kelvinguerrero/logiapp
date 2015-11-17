json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :total, :quantity, :expirationDate, :elaborationDate, :eradicateDate
  json.url invoice_url(invoice, format: :json)
end
