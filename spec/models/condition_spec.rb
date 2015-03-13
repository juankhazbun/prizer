require 'rails_helper'

describe Condition do
  
  subject(:condition) { build(:condition) }
  
  context 'relationships' do
    
    it { is_expected.to belong_to(:prize) }
    
  end
  
  it { is_expected.to be_valid }
  
  context 'is invalid' do
    
    it { is_expected.to validate_presence_of(:cond_type) }
    
    it { is_expected.to validate_inclusion_of(:cond_type).in_array(['%', '<', '>', 'list']) }
    
    it { is_expected.to validate_presence_of(:criteria) }
    
    it { is_expected.to validate_numericality_of(:offset) } 
    
    it 'when criteria is not a number' do
      condition.criteria = 'a'
      is_expected.to_not be_valid
    end
    
    it 'when criteria is not a list of numbers' do
      condition.criteria = 'a,a,a'
      is_expected.to_not be_valid
    end
      
  end
  
end