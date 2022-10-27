require 'rails_helper'

RSpec.describe "Dealers", type: :request do
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

  let(:dealer) do
    Dealer.create(name: 'Somename')
  end

  let(:params) do
    { dealer: {
        name: 'Another' } }
  end

  describe "GET /dealers for admin" do
    it "should show all dealers" do
      get dealers_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /dealers for admin" do
    it "should create new dealer" do
      post dealers_path, params: params
      new_dealer = Dealer.last
      expect(new_dealer.name).to eq "Another"
      expect(response).to redirect_to dealer_path(Dealer.last)
    end
  end

  describe "PUT /dealer/:id for admin" do
    it "should update dealer" do
      put dealer_path(dealer), params: params.merge(id: dealer.id)
      update_dealer = dealer.reload
      expect(update_dealer.name).to eq "Another"
      expect(response).to redirect_to dealer_path(Dealer.last)
    end
  end

  describe "DELETE /dealer/:id for admin" do
    it "should destroy dealer" do
      delete dealer_path(dealer)
      expect(response).to redirect_to(dealers_path)
    end
  end
end