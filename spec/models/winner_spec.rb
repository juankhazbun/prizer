require 'rails_helper'

describe Winner do
  
  subject(:winner) { build(:winner) }
  
  it { is_expected.to be_valid }
  
  context 'relationships' do
    
    it { is_expected.to belong_to(:subscriber) }
  
    it { is_expected.to belong_to(:prize) }
    
  end
  
end
