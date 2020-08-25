# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :oven do
    user
    name "MyString"
    timer Time.now
  end
end
