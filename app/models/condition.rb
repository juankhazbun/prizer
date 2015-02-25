class Condition < ActiveRecord::Base
  belongs_to :prize  
  
  validates :prize, presence: true
  validates :cond_type, presence: true, inclusion: { in: ['%', '<', '>', 'list'] }
  VALID_LIST_REGEX = /\A(\d+)(,\s*\d+)*/i
  validates :criteria, presence: true, format: { with: VALID_LIST_REGEX }
  validates :offset, allow_blank: true, numericality: { only_integer: true }
end
