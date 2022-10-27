require 'rails_helper'

RSpec.describe CarMarketplace::V1::Models, type: :request do
  let(:email) { 'test@test.com' }
  let(:password) { '123456'}

  let(:user) do
    User.create(
      email: email,
      password: password,
      password_confirmation: password,
      role: :admin)
  end

    before do
      post '/api/user/register', params: { email: user.email, password: password }
      @token = response.headers['Authorization']
    end

  describe 'GET /api/v1/models' do
    it 'returns all models' do
      get '/api/v1/models', headers: { Authorization:  @token}
      expect(response).to have_http_status(:success)
    end
  end
end