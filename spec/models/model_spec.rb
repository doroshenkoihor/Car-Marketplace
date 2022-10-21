require 'rails_helper'

RSpec.describe Model, type: :model do
  it { is_expected.to have_many(:cars).dependent(:destroy) }
  it { is_expected.to belong_to(:brand) }

  it { is_expected.to validate_presence_of(:name) }
end
