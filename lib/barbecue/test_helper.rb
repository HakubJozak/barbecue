FactoryGirl.define do
  trait :name do
    first_name  Faker::Name.first_name
    last_name  Faker::Name.last_name    
  end


  trait :email do
    email Faker::Internet.email
  end
  
  trait :phone do
    phone Faker::PhoneNumber.phone_number
  end
end
