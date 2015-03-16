require 'rails_helper'

describe Prize do
  
  subject(:prize) { build(:prize) }
  
  context 'relationships' do
    
    it { is_expected.to have_many(:conditions) }
    
    it { is_expected.to have_many(:winners) }
    
    it { is_expected.to have_many(:subscribers).through(:winners) }
    
  end  
  
  it { is_expected.to be_valid }
  
  context 'is invalid' do
  
      it { is_expected.to validate_presence_of(:description) }
      
      it { is_expected.to validate_length_of(:description).is_at_least(6).is_at_most(30) }
      
      it { is_expected.to validate_presence_of(:existences) }
      
      it { is_expected.to validate_numericality_of(:existences) }
      
  end
  
end
