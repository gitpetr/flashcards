FactoryGirl.define do
  
  factory :user do
    email "test@test.com"
    password "test"
    password_confirmation { password }
  end
end