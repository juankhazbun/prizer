FactoryGirl.define do
  factory :winner do    
    association :prize
    subscriber_id 1
    assigned true
    date_won Time.now
  
    factory :unassigned_winner do
      association :prize
      assigned false
      date_won Time.now
    end
  end

end
