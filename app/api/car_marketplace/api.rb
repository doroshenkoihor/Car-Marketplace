module CarMarketplace
  class API < Grape::API
    prefix 'api'
    mount CarMarketplace::V1::API
    mount CarMarketplace::V1::UserRegistrationAPI
  end
end