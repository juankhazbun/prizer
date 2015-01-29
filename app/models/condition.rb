class Condition < ActiveRecord::Base
  belongs_to :prize  
  validates :criteria, presence: true
  validates :offset, numericality: { only_integer: true }
end
