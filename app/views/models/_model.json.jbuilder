json.extract! model, :id, :name, :cars_count, :description, :brand_id, :created_at, :updated_at
json.url model_url(model, format: :json)
