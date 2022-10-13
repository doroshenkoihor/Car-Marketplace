module CarMarketplace
  module V1
    class Dealers < Grape::API
      version 'v1'
      format 'json'

      resource :dealers do
        desc "Create a new dealer"
        params do
          requires :name, type: String
          requires :description, type: String
        end
        post do
          authorize_admin!
          Dealer.create!({ name:params[:name], description:params[:description] })
        end



        desc "Return list of dealers"
        get do
          Dealer.all
        end


        desc "Return a specific dealer"
        route_param :id do
          get do
            dealer = Dealer.find(params[:id])
            present dealer
          end
        end
  
        desc "Update a specific dealer"
        route_param :id do
          put do
            authorize_admin!
            Dealer.find(params[:id]).update({ name:params[:name]})
          end
        end
  
        desc "Delete specific dealer"
        route_param :id do
          delete do
            authorize_admin!
            dealer = Dealer.find(params[:id])
            Dealer.destroy
          end
        end
      end
    end
  end
end