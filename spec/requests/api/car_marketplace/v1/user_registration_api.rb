require 'rails_helper'

RSpec.describe "User Registration API", type: :request do
  let(:email) { 'test@test.com' }
  let(:password) { '123456'}

  context 'with email and password' do
    it 'creates new user' do
      expect do
        post '/api/user/register', params: { email: email, password: password }
      end.to change(User, :count).by 1
    end

    it 'responses with jwt authorization token' do
      post '/api/user/register', params: { email: email, password: password }

      expect(response.headers['Authorization']).to match /(^[\w-]*\.[\w-]*\.[\w-]*$)/
    end
  end
end