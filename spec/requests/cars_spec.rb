require 'rails_helper'

RSpec.describe "Cars", type: :request do
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

  let!(:brand) { Brand.create(name: 'Somename8888s', description: 'Somedesccc') }

  let(:model) { Model.create(name: 'Somename', description: 'Sometext', cars_count: 1, brand_id: brand.id) }

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

  let(:params) do
    { car: {
        id: car.id,
        name: 'Challenger',
        fueltype: 'petrol',
        gearbox: 'manual',
        bodytype: 'sedan',
        price: 1000,
        dealer_id: dealer.id,
        model_id: model.id
    } }
  end

  let(:create_params) do
    { car: {
        name: 'Another',
        fueltype: 'diesel',
        gearbox: 'automatic',
        bodytype: 'coupe',
        price: 1212,
        dealer_id: dealer.id,
        model_id: model.id
    } }
  end

  describe "GET /cars for admin" do
    it "should show all cars" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /cars for admin" do
    it "should create new car" do
      post cars_path, params: create_params
      new_car = Car.last
      expect(response).to redirect_to car_path(Car.last)
      expect(new_car.name).to eq "Another"
      expect(new_car.price).to eq 1212
      expect(new_car.fueltype).to eq "diesel"
    end
  end

  describe "PUT /car/:id for admin" do
    it "should update car" do
      put car_path(car), params: params.merge(id: car.id)
      update_car = car.reload
      expect(response).to redirect_to car_path(Car.last)
      expect(update_car.name).to eq "Challenger"
      expect(update_car.price).to eq 1000
      expect(update_car.fueltype).to eq "petrol"
    end
  end

  describe "DELETE /car/:id for admin" do
    it "should destroy car" do
      delete car_path(car)
      expect(response).to redirect_to(cars_path)
    end
  end
end
