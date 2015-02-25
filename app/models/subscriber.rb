class Subscriber < ActiveRecord::Base    
  has_many :winners
  has_many :prizes, through: :winners
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates_uniqueness_of :email, conditions: -> { where(:created_at => (Time.now.beginning_of_day..Time.now.end_of_day)) }, :message => "can only be entered once a day"
  
  def check_prize(id)    
    
    prize_win = ""
    
    # Verify if the subscriber won a prize by carambola
    if (Winner.exists?(subscriber_id: id))
      
      # Get winner
      winner = Winner.where("subscriber_id = ?", id).first
      
      # Get assigned prize
      prize = Prize.where("id = ?", winner.prize_id).first
     
      puts "Carambola winner found. Prize assigned: #{prize.description}"
      
      # Mark winner as assigned
      winner.update_attribute(:assigned, true)
      
      prize_win = prize.description      
      
    else
    
      # Get all the conditions 
      conditions = Condition.all
      
      winner_conditions = []
      assigned_winner = true   
      
      puts "Checking conditions"
      
      # Traverse all conditions to apply to the id
      conditions.each do |condition|
        
        # Check if the type of the condition is a list
        if condition.cond_type == 'list'
          
          # Check if the id is in the string
          win = condition.criteria.include? id.to_s   
          
          puts "condition ##{condition.id} evaluated to " +  win.to_s     
          
        else
          
          # Check if the id is greater than the offset
          if condition.offset != "" || condition.offset.to_i < id     
            
            eval = id.send(condition.cond_type, condition.criteria.to_i)      
          
            # Check if the condition is fullfilled
            if eval.is_a? Integer
              win = eval == 0 ? true : false
            else
              win = eval
            end
            
            puts "condition ##{condition.id} evaluated to " +  win.to_s
          
          end
        end
        
        # Check if the subscriber win the condition
        if win
          
          prize = condition.prize
          
          puts "Prize related: #{prize.description} - existences: #{prize.existences}"
          
          # Check if the prize associated to that condition 
          if prize.existences > 0
            
            # Subscriber win the prize
            puts "Subscriber won a #{prize.description}"
            
            # Check if the winner is already in the list
            if (!Winner.exists?(subscriber_id: id))
            
              # Register winner
              Winner.create(subscriber_id: id, prize_id: prize.id, assigned: assigned_winner)
              
              # Decrement prize stock
              prize.decrement!(:existences)
              
              if (assigned_winner)
                prize_win = prize.description
                assigned_winner = false
              end
              
              # Increment the id for the carambola winner
              id = id + 1
            end
            
          end
          
        end
        
      end
      
    end
    return prize_win
  end
  
end
