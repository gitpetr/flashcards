FactoryGirl.define do

  factory :card do
    user
    pack
    original "haus"
    translated "home"
    term_review 0
    counter_review 0
  end
end

