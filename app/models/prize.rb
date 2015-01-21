class Prize < ActiveRecord::Base
  validates :description, presence: true, length: { in: 6..30 }
  validates :existences, presence: true, numericality: { only_integer: true }
end
