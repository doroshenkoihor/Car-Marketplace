class Dealer < ApplicationRecord
	has_many :cars

	validates :name, presence: true, uniqueness: true
end
