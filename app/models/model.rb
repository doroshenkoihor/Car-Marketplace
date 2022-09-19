class Model < ApplicationRecord
  has_many :childs, class_name: 'Model', foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: 'Model', optional: true
  belongs_to :brand
  has_many :cars
end
