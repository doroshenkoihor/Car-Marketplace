class Car < ApplicationRecord
  enum fueltype: { petrol: 0, diesel: 1 }
  enum bodytype: { micro: 0, sedan: 1, coupe: 2, suv: 3 }
  enum gearbox: { manual: 0, automatic: 1 }

  belongs_to :model, counter_cache: true
  belongs_to :dealer
  has_many :favorites

  has_one_attached :photo

  validates :fueltype, inclusion: { in: fueltypes.keys}
  validates :bodytype, inclusion: { in: bodytypes.keys}
  validates :gearbox, inclusion: { in: gearboxes.keys}

  scope :between_range, -> (min, max) { where("price >= ? OR price <= ?", min, max) }
end
