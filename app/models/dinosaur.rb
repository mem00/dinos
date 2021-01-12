class Dinosaur < ApplicationRecord
  belongs_to :cage, counter_cache: true
end
