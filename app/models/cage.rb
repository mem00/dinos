class Cage < ApplicationRecord
  has_many :dinosaurs, dependent: :destroy

  enum power_status: {
    active: 'active',
    down: 'down'
  }
end
