FactoryGirl.define do
  factory :condition do
    association :prize
    cond_type '%'
    criteria '5'    
  end

end
