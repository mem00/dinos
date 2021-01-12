class Cage < ApplicationRecord
  has_many :dinosaurs, dependent: :destroy
end
