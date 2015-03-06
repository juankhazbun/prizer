FactoryGirl.define do
  factory :prize do
    description "Prize #1"
    existences 1
    
    factory :new_prize do
      description "New Prize #1"
      existences 2
    end
  end

end
