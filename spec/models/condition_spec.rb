require 'rails_helper'

describe Condition do
  
  before :all do
    @condition = build(:condition)
  end
  
  it 'should belong to a prize' do
    should belong_to(:prize)
  end
  
  it 'is valid with a prize, type and criteria' do
    expect(@condition).to be_valid
  end
  
  it 'should allow a valid type' do
    should validate_inclusion_of(:cond_type).in_array(['%', '<', '>', 'list'])
  end
  
  context 'is invalid' do
    
    it 'whitout a type' do
      @condition.cond_type = nil
      expect(@condition).not_to be_valid
    end
    
    it 'whitout a criteria' do
      @condition.criteria = nil
      expect(@condition).not_to be_valid
    end
    
    it 'when criteria is not a number' do
      @condition.criteria = 'a'
      expect(@condition).not_to be_valid
    end
    
    it 'when criteria is not a list of numbers' do
      @condition.criteria = 'a,a,a'
      expect(@condition).not_to be_valid
    end
    
    it 'when offset is not numeric' do
        @condition.offset = 'a'
        expect(@condition).not_to be_valid
      end
  end
  
end