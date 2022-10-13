module CarMarketplace
  module V1
    class Brands < Grape::API
      version 'v1'
      format 'json'

      resource :brands do
        desc "Create a new brand"
        params do
          requires :name, type: String
          requires :description, type: String
        end
        post do
          authorize_admin!
          Brand.create!({ name:params[:name], description:params[:description] })
        end

        desc "Return list of brands"
        get do
          Brand.all
        end


        desc "Return a specific brand"
        route_param :id do
          get do
            brand = Brand.find(params[:id])
            present brand
          end
        end
  
        desc "Update a specific brand"
        route_param :id do
          put do
            authorize_admin!
            Brand.find(params[:id]).update({ name:params[:name]})
          end
        end
  
        desc "Delete specific brand"
        route_param :id do
          delete do
            authorize_admin!
            brand = Brand.find(params[:id])
            Brand.destroy
          end
        end
      end
    end
  end
end