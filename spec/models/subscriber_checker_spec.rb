require 'rails_helper'
require 'services/subscriber_checker'

describe SubscriberChecker do
  
  describe '#checker.check_prize' do   
    
    let(:subscriber) { build(:subscriber, id: 25) }
    
    before(:all) do
      checker = Services::SubscriberChecker.new
    end
    
    context 'when the subscriber won a prize by carambola' do
  
      it 'should change the assigned field' do        
        # Create an unassigned winner
        winner = create(:unassigned_winner, subscriber_id: 5)
        # Create a subscriber #5
        subscriber5 = build(:subscriber, id: 5)        
        
        # Expect to change the status of assigned to true
        expect { checker.check_prize(subscriber5) }.to change{ winner.reload.assigned }.from(false).to(true)
      end      
      
    end
      
    it 'should create a winner when subscriber id matches a list condition' do
      # Create a list condition
      condition = create(:list_condition)
      
      expect { checker.check_prize(subscriber) }.to change(Winner, :count).from(0).to(1)
      
    end
    
    it 'should create a winner when subscriber id matches a multiples condition' do
        # Create a condition that its condition type is %(multiples)
        condition = create(:condition)
        
        expect { checker.check_prize(subscriber) }.to change(Winner, :count).from(0).to(1)
      end
    
    it 'should not create a winner when the prize does not have existences' do
      # Create a condition with an associated prize with no existences
      condition = create(:condition_unavailable_prize)
      
      expect { checker.check_prize(subscriber) }.to_not change(Winner, :count)
    end
    
    it 'should create just one winner when the subscriber id matches 2 conditions and one of them does not have existences' do
      # Create a condition with an associated prize with 1 existences
      condition = create(:condition)
      # Create a condition with unavailable prize
      condition = create(:condition_unavailable_prize)
      
      expect { checker.check_prize(subscriber) }.to change(Winner, :count).from(0).to(1)
    end
    
    it 'should create winners for all the conditions that the subscriber id matches' do      
      # create a condition with a list of multiples of 5
      condition1 = create(:list_condition)
      # Create a condition for multiples of 5
      condition2 = create(:condition)
      # Create a condition for ids greater than 24
      condition3 = create(:greater_than_condition)
      
      expect { checker.check_prize(subscriber) }.to change(Winner, :count).from(0).to(3)
    end
    
    it 'should not create a carambola winner when a subscriber id matches 2 conditions but the carambola winner id is already registered in the database' do
      # create a condition with a list of multiples of 5
      condition1 = create(:list_condition)
      # Create a condition for multiples of 5
      condition2 = create(:condition)
      # Create winner with subscriber #26(carambola winner from subscriber #25)
      winner = create(:unassigned_winner, subscriber_id: 26)
      
      expect { checker.check_prize(subscriber) }.to change(Winner, :count).by(1) 
    end
    
    it 'should not create a winner when the subscriber id is less than the offset of the condition' do
      # Create the condition
      condition = create(:condition_with_offset)
      
      expect { checker.check_prize(subscriber) }.to_not change(Winner, :count)
    end
    
    it 'should create a winner when the subscriber id is greater than the offset of the condition' do
      # Create the condition
      condition = create(:condition_with_offset)
      # Change subscriber id
      subscriber.id = 125
      
      expect { checker.check_prize(subscriber) }.to change(Winner, :count).by(1)
    end
    
  end
  
end
