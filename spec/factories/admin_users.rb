FactoryGirl.define do
  factory :admin_user do
    email 'admin@example.com'
    password 'password'
    
    factory :invalid_admin_email do
      email { Faker::Internet.email }
      password 'password'
    end
    
    factory :invalid_admin_password do
      email 'admin@example.com'
      password ''
    end
  end

end
