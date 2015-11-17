json.array!(@logi_bills) do |logi_bill|
  json.extract! logi_bill, :id, :name, :total
  json.url logi_bill_url(logi_bill, format: :json)
end
