module CarMarketplace
  module V1
    class UserRegistrationAPI < Grape::API
      namespace :user do
        namespace :register do
          before do
            @service = UserRegistrationWithEmailService.new(params[:email], params[:password])
          end
  
          # set response headers
          after do
            header 'Authorization', @service.token
          end
  
          post do
            @service.register
          end
        end
      end
    end
  end
end