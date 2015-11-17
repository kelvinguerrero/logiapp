json.array!(@dispatches) do |dispatch|
  json.extract! dispatch, :id, :manifestNumber, :loadOrder, :advance, :balance
  json.url dispatch_url(dispatch, format: :json)
end
