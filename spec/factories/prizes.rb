FactoryGirl.define do
  factory :prize do
    description "Prize #1"
    existences 25
  
    factory :new_prize do
      description "New Prize #1"
      existences 2
    end
    
    factory :unavailable_prize do
      description "Unavailable prize"
      existences 0
    end
  end

end
