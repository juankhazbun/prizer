require 'rails_helper'

describe Subscriber do   
  
  describe '#validate' do
    
    let(:subscriber) { build(:subscriber) }
  
    it 'should have many winners' do
      should have_many(:winners)
    end
    
    it 'should have many prizes through winners' do
      should have_many(:prizes).through(:winners)
    end
      
    context 'is invalid' do
      
      it 'when required email is not given' do        
        subscriber.email = ''
        should_not be_valid
      end
      
      it 'when email format is not valid' do
        subscriber.email = 'invalid mail'
        should_not be_valid
      end
      
      it 'when email address is alreday subscribed' do
        subscriber.email = "123@example.com"
        subscriber.save
        user_with_same_email = subscriber.dup
        user_with_same_email.save
        should_not be_valid
      end
      
    end
    
  end
  
  describe '#check_prize' do   
    
    let!(:subscriber) { create(:subscriber, id: 25) }
    
    context 'when the subscriber won a prize by carambola' do
  
      it 'should change the assigned field' do        
        # Create an unassigned winner
        winner = create(:unassigned_winner, subscriber_id: 5)
        # Create a subscriber #5
        subscriber5 = create(:subscriber, id: 5)        
        
        # Expect to change the status of assigned to true
        expect { subscriber5.check_prize }.to change{ winner.reload.assigned }.from(false).to(true)
      end      
      
    end
      
    it 'should create a winner when subscriber id matches a list condition' do
      # Create a list condition
      condition = create(:list_condition)
      
      expect { subscriber.check_prize }.to change(Winner, :count).from(0).to(1)
      
    end
    
    it 'should create a winner when subscriber id matches a multiples condition' do
        # Create a condition that its condition type is %(multiples)
        condition = create(:condition)
        
        expect { subscriber.check_prize }.to change(Winner, :count).from(0).to(1)
      end
    
    it 'should not create a winner when the prize does not have existences' do
      # Create a condition with an associated prize with no existences
      condition = create(:condition_unavailable_prize)
      
      expect { subscriber.check_prize }.to_not change(Winner, :count)
    end
    
    it 'should create just one winner when the subscriber id matches 2 conditions and one of them does not have existences' do
      # Create a condition with an associated prize with 1 existences
      condition = create(:condition)
      # Create a condition with unavailable prize
      condition = create(:condition_unavailable_prize)
      
      expect { subscriber.check_prize }.to change(Winner, :count).from(0).to(1)
    end
    
    it 'should create winners for all the conditions that the subscriber id matches' do      
      # create a condition with a list of multiples of 5
      condition1 = create(:list_condition)
      # Create a condition for multiples of 5
      condition2 = create(:condition)
      # Create a condition for ids greater than 24
      condition3 = create(:greater_than_condition)
      
      expect { subscriber.check_prize }.to change(Winner, :count).from(0).to(3)
    end
    
    it 'should not create a carambola winner when a subscriber id matches 2 conditions but the carambola winner id is already registered in the database' do
      # create a condition with a list of multiples of 5
      condition1 = create(:list_condition)
      # Create a condition for multiples of 5
      condition2 = create(:condition)
      # Create winner with subscriber #26(carambola winner from subscriber #25)
      winner = create(:unassigned_winner, subscriber_id: 26)
      
      expect { subscriber.check_prize }.to change(Winner, :count).by(1) 
    end
    
    it 'should not create a winner when the subscriber id is less than the offset of the condition' do
      # Create the condition
      condition = create(:condition_with_offset)
      
      expect { subscriber.check_prize }.to_not change(Winner, :count)
    end
    
    it 'should create a winner when the subscriber id is greater than the offset of the condition' do
      # Create the condition
      condition = create(:condition_with_offset)
      # Change subscriber id
      subscriber.id = 125
      
      expect { subscriber.check_prize }.to change(Winner, :count).by(1)
    end
    
  end
  
  
end
