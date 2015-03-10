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
    
    factory :new_admin_user do
      email { Faker::Internet.email }
      password { Faker::Internet.password }
    end
    
    factory :new_admin_password do
      password { Faker::Internet.password }
    end
  end

end
