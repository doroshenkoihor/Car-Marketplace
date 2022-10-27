require 'rails_helper'

RSpec.describe Car, type: :model do
  it { is_expected.to have_one(:photo_attachment) }
  it { is_expected.to belong_to(:model).counter_cache(true) }
  it { is_expected.to belong_to(:dealer) }
  it { is_expected.to have_many(:favorites) }

  it { is_expected.to validate_presence_of(:name) }
  it { should define_enum_for(:fueltype).with_values([:petrol, :diesel]) }
  it { should define_enum_for(:bodytype).with_values([:micro, :sedan, :coupe, :suv]) }
  it { should define_enum_for(:gearbox).with_values([:manual, :automatic]) }
end
