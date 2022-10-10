ActiveAdmin.register Car do
  permit_params :name, :fueltype, :bodytype, :gearbox, :price, :photo, :dealer_id, :model_id

  form do |f|
    inputs "Details" do
      input :name
      input :fueltype
      input :bodytype
      input :gearbox
      input :price
      input :photo, as: :file
      input :dealer
      input :model
    end
  end
end
