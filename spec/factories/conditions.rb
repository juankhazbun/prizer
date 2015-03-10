FactoryGirl.define do
  factory :condition do
    association :prize
    cond_type '%'
    criteria '5' 
  
    factory :list_condition do
      association :prize
      cond_type 'list'
      criteria '15, 25, 35'
    end
    
    factory :greater_than_condition do
      association :prize
      cond_type '>'
      criteria '24'
    end
    
    factory :new_condition do
      association :prize
      cond_type 'greater than'
      criteria '24'
    end   
    
    factory :condition_desc do
      association :prize
      cond_type 'multiples'
      criteria '6'
    end
    
    factory :condition_unavailable_prize do
      association :prize, factory: :unavailable_prize
      cond_type 'list'
      criteria '25'
    end
    
    factory :condition_with_offset do
      association :prize
      cond_type '%'
      criteria '5'
      offset '100'
    end
  end
end
