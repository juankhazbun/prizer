require 'rails_helper'

describe Subscriber, :type => :model do
    
    context 'is invalid' do
      
      before :all do
        @subscriber = Subscriber.new
      end
      
      it 'when required email is not given' do        
        @subscriber.email = ''
        should_not be_valid
      end
      
      it 'when email format is not valid' do
        @subscriber.email = 'invalid mail'
        should_not be_valid
      end
      
    end
  
  
end
