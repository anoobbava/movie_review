json.array!(@models) do |model|
  json.extract! model, :id, :Movie, :title, :description, :movie_length, :director, :rating
  json.url model_url(model, format: :json)
end
