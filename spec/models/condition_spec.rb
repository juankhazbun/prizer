require 'rails_helper'

RSpec.describe Condition, :type => :model do
  
  context 'is invalid' do
    
    before :all do
        @condition = Condition.new
      end
    
    it 'when description is empty' do
      @condition.criteria = ''
      should_not be_valid
    end
    
    it 'when offset is not numeric' do
        @condition.offset = 'a'
        should_not be_valid
      end
  end
  
end
