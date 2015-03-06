FactoryGirl.define do
  factory :condition do
    association :prize
    cond_type '%'
    criteria '5' 
    
    factory :new_condition do
      association :prize
      cond_type 'greater than'
      criteria '6'
    end   
    
    factory :condition_desc do
      association :prize
      cond_type 'multiples'
      criteria '6'
    end
  end
end
