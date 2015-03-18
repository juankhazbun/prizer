class Subscriber < ActiveRecord::Base    
  has_many :winners
  has_many :prizes, through: :winners
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates_uniqueness_of :email, conditions: -> { where(:created_at => (Time.now.beginning_of_day..Time.now.end_of_day)) }, 
      :message => "can only be entered once a day"
  
end
