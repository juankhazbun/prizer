# Helper to save a subscriber and check for
# prizes applying the existing conditions
#
# @author   Juan Carlos Hazbun Nieto<mailto:juankhazbun@gmail.com>
# @version  1.0, May 2015
# @since    1.0
class SubscriberChecker
  
  attr_accessor :subscriber 
  
  def initialize(subscriber_params)
    # Create the new subscriber
    @subscriber = Subscriber.new(subscriber_params)    
  end
  
  # Register the subscriber and check if the subscriber 
  # id match with the existing conditions
  #
  # === Return
  # * information of the assigned prize or false if there 
  # was a problem registering the subscriber
  def check_subscriber 
    
    if @subscriber.save
      
      # Check if the subscriber wins a prize      
      return prize_won()
      
    end
    
    return "error"
  end
  
  private 
  # Function to check if a subscriber won a prize
  # applying the existing conditions
  #   
  # === Return
  # * +prize_won+ - Description of the awarded prize
  #
  # Author::  Juan Carlos Hazbun Nieto
  # Version:: 2.0, March 2015
  def prize_won
    
    next_id = @subscriber.id # used for carambola winners
    
    prize_won = check_for_carambola_winner()
    
    # Verify if the subscriber won a prize by carambola
    if (prize_won == false) 
    
      # Get all the conditions 
      conditions = Condition.all
      assigned_winner = true   
      
      # Traverse all conditions to match the subscriber id
      conditions.each do |condition|
        
        # Check if the subscriber id matches the condition
        if condition_match?(condition)
          
          # Assign a prize to a the subscriber
          if assign_prize?(next_id, condition.prize, assigned_winner)
            
            if (assigned_winner)
              prize_won = condition.prize.description
              assigned_winner = false
            end
            
            # Increment the id for the carambola winner
            next_id = next_id + 1
          end
          
        end
        
      end
      
    end
    return prize_won
  end
  
  # Check if a subscriber won a prize by carambola
  # Assign the prize to the subscriber
  #
  # === Return
  # * +carambola_winner+ - assigned prize
  #
  # Author::  Juan Carlos Hazbun Nieto
  # Version:: 2.0, March 2015  
  def check_for_carambola_winner
    
    carambola_winner = false
    
    # Verify if the subscriber won a prize by carambola
    if (Winner.exists?(subscriber_id: @subscriber.id))
      
      # Get winner
      winner = Winner.where("subscriber_id = ?", @subscriber.id).first
      
      # Get assigned prize
      prize = Prize.where("id = ?", winner.prize_id).first
      
      # Mark winner as assigned
      winner.update_attribute(:assigned, true)
      
      carambola_winner = prize.description    
    end  
    return carambola_winner
  end
  
  # Check if the subscriber id matches a condition 
  # 
  # === Param
  # * +condition+ - condition information
  #
  # === Return 
  # * +match+ - returns true if subscriber id match the condition 
  #
  # Author::  Juan Carlos Hazbun Nieto
  # Version:: 2.0, March 2015    
  def condition_match?(condition)
    
    # Check if the type of the condition is a list
    if condition.cond_type == 'list'
      
      # Check if the id is in the string
      match = condition.criteria.include? subscriber.id.to_s 
      
    else
      
      # Check if the id is greater than the offset
      if condition.offset == "" || condition.offset.to_i < subscriber.id     
        
        eval = subscriber.id.send(condition.cond_type, condition.criteria.to_i)   
      
        # Check if the condition is fullfilled
        if eval.is_a? Integer
          match = eval == 0 ? true : false
        else
          match = eval
        end
        
      end
    end
    return match
  end
  
  # Assign a prize to a the subscriber
  #
  # === Param
  # * +subscriber_id+ - id of the winner (could be a carambola winner)
  # * +prize+ - prize information
  # * +assigned+ - status of the prize (false for carambola winners)
  #
  # === Return
  # +true if the prize was successfully assigned+
  #
  # Author::  Juan Carlos Hazbun Nieto
  # Version:: 2.0, March 2015    
  def assign_prize?(subscriber_id, prize, assigned)
    
    # Check if the prize associated to that condition 
    if prize.existences > 0
      
      # Check if the winner is already in the list
      if (!Winner.exists?(subscriber_id: subscriber_id))
      
        # Register winner
        new_winner = Winner.create(subscriber_id: subscriber_id, prize_id: prize.id, assigned: assigned, date_won: Time.now)
        
        # Decrement prize stock
        prize.decrement!(:existences)      
        
        return true  
        
      end
      
    end
    return false
  end
  
end