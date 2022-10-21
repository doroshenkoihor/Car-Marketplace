class Model < ApplicationRecord
  belongs_to :brand
  has_many :cars, dependent: :destroy

  validates :name, presence: true
end
