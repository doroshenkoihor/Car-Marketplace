json.extract! car, :id, :name, :fueltype, :bodytype, :gearbox, :price, :model_id, :dealer_id, :created_at, :updated_at
json.url car_url(car, format: :json)
