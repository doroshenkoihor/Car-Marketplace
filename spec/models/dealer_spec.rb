require 'rails_helper'

RSpec.describe Dealer, type: :model do
  it { is_expected.to have_many(:cars) }

  it { is_expected.to validate_uniqueness_of(:name) }
end
