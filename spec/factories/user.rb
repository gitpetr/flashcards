FactoryGirl.define do
  
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password "test"
    password_confirmation { password }
  end
end
