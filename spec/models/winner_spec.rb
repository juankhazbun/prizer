require 'rails_helper'

describe Winner do
  
  before :all do
    @winner = build(:winner)
  end
  
  it 'should belong to subscriber' do
    should belong_to(:subscriber)
  end
  
  it 'should belong to a prize' do
    should belong_to(:prize)
  end 
  
  it 'is valid with a prize and assignation status(assigned)' do
    expect(@winner).to be_valid
  end   
  
end
