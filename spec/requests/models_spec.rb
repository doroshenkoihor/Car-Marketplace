require 'rails_helper'

RSpec.describe "Models", type: :request do
  let(:user) do
    User.create(
      email: 'Brad@email.com',
      password: '222',
      password_confirmation: '222',
      role: :admin)
  end

  before(:each) do
    sign_in(user)
  end

    let!(:dealer) { Dealer.create(name: 'Dealer') }

  let(:car) {
    Car.create(
      name: 'Somename',
      fueltype: 1,
      gearbox: 0,
      bodytype: 2,
      price: 22,
      model_id: model.id,
      dealer_id: dealer.id
      )
  }

  let!(:brand) { Brand.create(name: 'Somename8888s', description: 'Somedesccc') }

  let(:model) do
    Model.create(name: 'Somename', description: 'Sometext', cars_count: 1, brand_id: brand.id)
  end

  let(:params) do
    { model: {
        name: 'Another',
        description: 'Somedescription',
        cars_count: 2,
        brand_id: brand.id
    } }
  end

  describe "GET /models for admin" do
    it "should show all models" do
      get models_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /models for admin" do
    it "should create new models" do
      post models_path, params: params
      new_model = Model.last
      expect(new_model.name).to eq "Another"
      expect(new_model.description).to eq "Somedescription"
      expect(response).to redirect_to model_path(Model.last)
    end

    it "has a counter cache" do
      model
      expect { model.cars.create{ car } }.to change { Model.last.cars_count }.by(1)
    end
  end

  describe "PUT /model/:id for admin" do
    it "should update model" do
      put model_path(model), params: params.merge(id: model.id)
      update_model = model.reload
      expect(update_model.name).to eq "Another"
      expect(update_model.description).to eq "Somedescription"
      expect(response).to redirect_to model_path(Model.last)
    end
  end

  describe "DELETE /model/:id for admin" do
    it "should destroy model" do
      delete model_path(model)
      expect(response).to redirect_to(models_path)
    end
  end
end
