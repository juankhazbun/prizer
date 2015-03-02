require 'rails_helper'

describe Subscriber do
  
  before :all do
    @subscriber = build(:subscriber)
  end
  
  it 'should have many winners' do
    should have_many(:winners)
  end
  
  it 'should have many prizes through winners' do
    should have_many(:prizes).through(:winners)
  end
    
  context 'is invalid' do
    
    it 'when required email is not given' do        
      @subscriber.email = ''
      should_not be_valid
    end
    
    it 'when email format is not valid' do
      @subscriber.email = 'invalid mail'
      should_not be_valid
    end
    
    it 'when email address is alreday subscribed' do
      @subscriber.email = "123@example.com"
      @subscriber.save
      user_with_same_email = @subscriber.dup
      user_with_same_email.save
      should_not be_valid
    end
    
  end
  
  
end
