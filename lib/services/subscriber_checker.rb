# Helper to save a subscriber and check for
# prizes applying the existing conditions
#
# @author   Juan Carlos Hazbun Nieto<mailto:juankhazbun@gmail.com>
# @version  1.0, May 2015
# @since    1.0
module Services 
  class SubscriberChecker
    
    # Register the subscriber and check if the subscriber 
    # id match with the existing conditions
    #
    # === Param
    # * +subscriber+ - new subscriber
    #
    # === Return
    # * information of the assigned prize or false if there 
    # was a problem registering the subscriber
    def check_subscriber(subscriber)      
      
      if subscriber.save
        
        # Check if the subscriber win a prize
        status =  check_prize(subscriber.id)
        
        return status
        
      end
      
      return "error"
    end
    
    # Function to check if a subscriber won a prize
    # applying the existing conditions
    #
    # === Param
    # * +subscriber_id+ - id of the subscriber
    #   
    # === Return
    # * +prize_won+ - Description of the awarded prize
    #
    # Author::  Juan Carlos Hazbun Nieto
    # Version:: 2.0, March 2015
    def check_prize(subscriber_id) 
      
      id = subscriber_id
      
      prize_won = check_for_carambola_winner(subscriber_id)
      
      # Verify if the subscriber won a prize by carambola
      if (prize_won == false) 
      
        # Get all the conditions 
        conditions = Condition.all
        assigned_winner = true   
        
        # Traverse all conditions to match the subscriber id
        conditions.each do |condition|
          
          # Check if the subscriber id matches the condition
          if condition_match?(subscriber_id, condition)
            
            # Assign a prize to a the subscriber
            if assign_prize?(id, condition.prize, assigned_winner)
              
              if (assigned_winner)
                prize_won = condition.prize.description
                assigned_winner = false
              end
              
              # Increment the id for the carambola winner
              id = id + 1
            end
            
          end
          
        end
        
      end
      return prize_won
    end
    
    private
    # Check if a subscriber won a prize by carambola
    # Assign the prize to the subscriber
    #
    # === Param
    # * +subscriber_id+ - id of the subscriber
    #
    # === Return
    # * +carambola_winner+ - assigned prize
    #
    # Author::  Juan Carlos Hazbun Nieto
    # Version:: 2.0, March 2015  
    def check_for_carambola_winner(subscriber_id)
      
      carambola_winner = false
      
      # Verify if the subscriber won a prize by carambola
      if (Winner.exists?(subscriber_id: subscriber_id))
        
        # Get winner
        winner = Winner.where("subscriber_id = ?", subscriber_id).first
        
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
    # * +subscriber_id+ - id of the subscriber
    # * +condition+ - condition information
    #
    # === Return 
    # * +match+ - returns true if subscriber id match the condition 
    #
    # Author::  Juan Carlos Hazbun Nieto
    # Version:: 2.0, March 2015    
    def condition_match?(subscriber_id, condition)
      
      # Check if the type of the condition is a list
      if condition.cond_type == 'list'
        
        # Check if the id is in the string
        match = condition.criteria.include? subscriber_id.to_s 
        
      else
        
        # Check if the id is greater than the offset
        if condition.offset == "" || condition.offset.to_i < subscriber_id     
          
          eval = subscriber_id.send(condition.cond_type, condition.criteria.to_i)   
        
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
    # * +subscriber_id+ - id of the subscriber 
    # * +prize+ - prize information
    # * +assigned+ - status of the prize (false for carambola winners)
    #
    # === Return
    #
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
end