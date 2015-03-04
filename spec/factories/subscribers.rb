FactoryGirl.define do
  factory :subscriber do 
    email { Faker::Internet.email }
    
    factory :invalid_subscriber do
      email 'a'
    end
  end  
end