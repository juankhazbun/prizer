require 'rails_helper'
require 'services/subscriber_checker'

describe 'Koombea Test' do
  
  before(:each) {
    # Create prize
    create(:prize, existences: 100)
    # Wins prize subscribers #50, #100, #2000
    create(:koombea_condition_a)
    # Wins prize subscribers multiples of 500
    create(:koombea_condition_b)
    # Wins prize subscribers multiples of 50 after 1000 subscribers
    create(:koombea_condition_c)    
  }
  
  it 'subscriber #100 won a prize matching condition (a)' do
    100.times do
      # Create service to check subscriber
      @checker = SubscriberChecker.new(attributes_for(:subscriber))
      @prize = @checker.check_subscriber
    end
    expect(@prize).to eq('Prize #1')
  end
  
  it 'subscriber #500 won a prize matching condition (b)' do
    500.times do
      # Create service to check subscriber
      @checker = SubscriberChecker.new(attributes_for(:subscriber))
      @prize = @checker.check_subscriber
    end
    expect(@prize).to eq('Prize #1')
  end
  
  it 'subscriber #1500 won a prize matching condition (b) and (c)' do
    1499.times do
      # Create service to check subscriber
      @checker = SubscriberChecker.new(attributes_for(:subscriber))
      @prize = @checker.check_subscriber
    end
    # Subscriber #1500 wins for rule (b) and subscriber #1501 by carambola matching rule (c)
    @checker = SubscriberChecker.new(attributes_for(:subscriber))
    expect { @checker.check_subscriber }.to change(Winner, :count).by(2) 
  end
  
  it 'subscriber #2000 won a prize matching condition (a), (b) and (c)' do
    1999.times do
      # Create service to check subscriber
      @checker = SubscriberChecker.new(attributes_for(:subscriber))
      @prize = @checker.check_subscriber
    end
    # Subscriber #2000 wins for rule (a), subscriber #2001 by carambola matching rule (b) 
    # and subscriber #2002 by carambola matching rule (c) 
    @checker = SubscriberChecker.new(attributes_for(:subscriber))
    expect { @checker.check_subscriber }.to change(Winner, :count).by(3) 
  end
end
