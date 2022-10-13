module CarMarketplace
  module V1
    class API < Grape::API
      helpers AuthHelpers

      before { authenticate! }

      mount CarMarketplace::V1::Brands
      mount CarMarketplace::V1::Models
      mount CarMarketplace::V1::Dealers
      mount CarMarketplace::V1::Cars
    end
  end
end