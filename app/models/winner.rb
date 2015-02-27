class Winner <ActiveRecord::Base
  belongs_to :subscriber
  belongs_to :prize
  
  # validates :subscriber, presence: true
  validates :prize, presence: true
  validates :assigned, inclusion: { in: [true, false] }
end