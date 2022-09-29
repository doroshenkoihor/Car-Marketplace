class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates_uniqueness_of :user_id, scope: :car_id
end
