module CarMarketplace
  module V1
    class Models < Grape::API
      version 'v1'
      format 'json'

      resource :models do
        desc "Create a new model"
        params do
          requires :name, type: String
          requires :description, type: String
          requires :cars_count, type: Integer
          requires :brand_id, type: Integer
        end
        post do
          authorize_admin!
          Model.create!({ name: params[:name], description: params[:description], cars_count: params[:cars_count], brand_id: params[:brand_id] })
        end



        desc "Return list of models"
        get do
          Model.all
        end


        desc "Return a specific model"
        route_param :id do
          get do
            model = Model.find(params[:id])
            present model
          end
        end
  
        desc "Update a specific model"
        route_param :id do
          put do
            authorize_admin!
            Model.find(params[:id]).update({ name:params[:name]})
          end
        end
  
        desc "Delete specific model"
        route_param :id do
          delete do
            authorize_admin!
            model = Model.find(params[:id])
            Model.destroy
          end
        end
      end
    end
  end
end