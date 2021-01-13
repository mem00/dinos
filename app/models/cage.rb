class Cage < ApplicationRecord
  has_many :dinosaurs, dependent: :destroy

  MAX_IN_CAGE = 3

  enum power_status: {
    active: 'active',
    down: 'down'
  }

  def has_space?
    dinosaurs_count < MAX_IN_CAGE
  end

  def is_empty?
    dinosaurs_count == 0
  end
end
