class Brand < ApplicationRecord
	has_many :models, dependent: :destroy

	validates :name, presence: true, uniqueness: true
	validates :description, presence: true
end
