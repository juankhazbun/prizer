require 'rails_helper'

RSpec.describe Prize, :type => :model do
  
  context 'is invalid' do
    
      before :all do
        @prize = Prize.new
      end
  
      it 'when required description is not given' do        
        @prize.description = ''
        should_not be_valid
      end
      
      it 'when description is too long' do
        @prize.description = 'a' * 40
        should_not be_valid
      end
      
      it 'when description is too short' do
        @prize.description = 'a' * 4
        should_not be_valid
      end
      
      it 'when required existences is not given' do        
        @prize.existences = nil
        should_not be_valid
      end
      
      it 'when existences is not numeric' do
        @prize.existences = 'a'
        should_not be_valid
      end
      
  end
  
end
