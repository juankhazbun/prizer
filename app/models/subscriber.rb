class Subscriber < ActiveRecord::Base    
  has_many :winners
  has_many :prizes, through: :winners
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates_uniqueness_of :email, conditions: -> { where(:created_at => (Time.now.beginning_of_day..Time.now.end_of_day)) }, 
      :message => "can only be entered once a day"
  
  # Function to check if a subscriber won a prize
  # applying the existing conditions
  #   
  # === Return
  # * +prize_won+ - Description of the awarded prize
  #
  # Author::  Juan Carlos Hazbun Nieto
  # Version:: 2.0, March 2015
  def check_prize 
    
    id = self.id
    
    prize_won = ""
    
    # Verify if the subscriber won a prize by carambola
    if (Winner.exists?(subscriber_id: self.id))
      
      # Get winner
      winner = Winner.where("subscriber_id = ?", self.id).first
      
      # Get assigned prize
      prize = Prize.where("id = ?", winner.prize_id).first
      
      # Mark winner as assigned
      winner.update_attribute(:assigned, true)
      
      prize_won = prize.description      
      
    else
    
      # Get all the conditions 
      conditions = Condition.all
      assigned_winner = true   
      
      # Traverse all conditions to apply to the id
      conditions.each do |condition|
        
        # Check if the type of the condition is a list
        if condition.cond_type == 'list'
          
          # Check if the id is in the string
          win = condition.criteria.include? self.id.to_s 
          
        else
          
          # Check if the id is greater than the offset
          if condition.offset == "" || condition.offset.to_i < self.id     
            
            eval = self.id.send(condition.cond_type, condition.criteria.to_i)   
          
            # Check if the condition is fullfilled
            if eval.is_a? Integer
              win = eval == 0 ? true : false
            else
              win = eval
            end
            
          end
        end
        
        # Check if the subscriber win the condition
        if win
          
          #puts "condition##{condition.id} won with criteria: #{condition.criteria}"
          
          prize = condition.prize
          
          # Check if the prize associated to that condition 
          if prize.existences > 0
            
            # Check if the winner is already in the list
            if (!Winner.exists?(subscriber_id: id))
            
              # Register winner
              new_winner = Winner.create(subscriber_id: id, prize_id: prize.id, assigned: assigned_winner, date_won: Time.now)
              
              # Decrement prize stock
              prize.decrement!(:existences)
              
              if (assigned_winner)
                prize_won = prize.description
                assigned_winner = false
              end
              
              # Increment the id for the carambola winner
              id = id + 1
            end
            
          end
          
        end
        
      end
      
    end
    return prize_won
  end
  
end
