require 'rails_helper'

describe Subscriber do   
    
  subject(:subscriber) { build(:subscriber) }
  
  context 'relationships' do

    it { is_expected.to have_many(:winners) }
    
    it { is_expected.to have_many(:prizes).through(:winners) }
    
  end
  
  context 'is valid' do
    
    it { is_expected.to be_valid }
    
    it { is_expected.to allow_value("example@example.com").for(:email) }
  end
    
  context 'is invalid' do
    
    it { is_expected.to validate_presence_of(:email) }  
    
    it { is_expected.to_not allow_value("foo").for(:email) }
    
    it 'should not allow email to be repeated in the same day' do
      #subscriber.save
      #user_with_same_email = subscriber.dup
      subscriber.dup.save
      is_expected.to_not be_valid
    end
  
  end
  
end
