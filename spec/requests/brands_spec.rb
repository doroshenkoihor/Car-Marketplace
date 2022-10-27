require 'rails_helper'

RSpec.describe "Brands", type: :request do
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

  let(:brand) do
    Brand.create(name: 'Somename', description: 'Sometext')
  end

  let(:params) do
    { brand: {
        name: 'Another',
        description: 'Somedescription'
    } }
  end

  describe "GET /brands for admin" do
    it "should show all brands" do
      get brands_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /brands for admin" do
    it "should create new brand" do
      post brands_path, params: params
      new_brand = Brand.last
      expect(new_brand.name).to eq "Another"
      expect(new_brand.description).to eq "Somedescription"
      expect(response).to redirect_to brand_path(Brand.last)
    end
  end

  describe "PUT /brand/:id for admin" do
    it "should update brand" do
      put brand_path(brand), params: params.merge(id: brand.id)
      update_brand = brand.reload
      expect(update_brand.name).to eq "Another"
      expect(update_brand.description).to eq "Somedescription"
      expect(response).to redirect_to brand_path(Brand.last)
    end
  end

  describe "DELETE /brand/:id for admin" do
    it "should destroy brand" do
      delete brand_path(brand)
      expect(response).to redirect_to(brands_path)
    end
  end
end