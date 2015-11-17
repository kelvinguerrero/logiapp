json.array!(@concepts) do |concept|
  json.extract! concept, :id, :container, :description, :route
  json.url concept_url(concept, format: :json)
end
