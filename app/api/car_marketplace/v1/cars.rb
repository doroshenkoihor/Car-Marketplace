module CarMarketplace
  module V1
    class Cars < Grape::API
      version 'v1'
      format 'json'

      resource :cars do
        desc "Create a new car"
        params do
          requires :name, type: String
          requires :fueltype, type: Integer
          requires :gearbox, type: Integer
          requires :bodytype, type: Integer
          requires :price, type: Integer
          requires :model_id, type: Integer
          requires :dealer_id, type: Integer
        end
        post do
          authorize_admin!
          Car.create!({
           name: params[:name],
           fueltype: params[:fueltype],
           gearbox: params[:gearbox],
           bodytype: params[:bodytype],
           price: params[:bodytype],
           model_id: params[:model_id],
           dealer_id: params[:dealer_id],
          })
        end



        desc "Return list of cars"
        get do
          Car.all
        end


        desc "Return a specific car"
        route_param :id do
          get do
            car = Car.find(params[:id])
            present car
          end
        end

        desc "Update a specific car"
        route_param :id do
          put do
            authorize_admin!
            Car.find(params[:id]).update({
             name: params[:name],
             fueltype: params[:fueltype],
             gearbox: params[:gearbox],
             bodytype: params[:bodytype],
             price: params[:bodytype],
             model_id: params[:model_id],
             dealer_id: params[:dealer_id],
            })
          end
        end
  
        desc "Delete specific car"
        route_param :id do
          delete do
            authorize_admin!
            car = Car.find(params[:id])
            car.destroy
          end
        end
      end
    end
  end
end