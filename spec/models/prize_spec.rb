require 'rails_helper'

describe Prize do
  
  before :all do
    @prize = build(:prize)
  end
  
  context 'should have' do
    
    it 'many conditions' do
      should have_many(:conditions)
    end
    
    it 'many winners' do
      should have_many(:winners)
    end
    
    it 'subscribers' do
      should have_many(:subscribers)
    end
    
  end  
  
  it 'is valid with a description and number of existences' do
    expect(@prize).to be_valid
  end
  
  context 'is invalid' do
  
      it 'when description is not given' do        
        @prize.description = ''
        should_not be_valid
      end
      
      it 'when description is too short' do
        @prize.description = 'a' * 4
        should_not be_valid
      end
      
      it 'when description is too long' do
        @prize.description = 'a' * 40
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
