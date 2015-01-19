# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    title "MyString"
    description "MyText"
    start "2015-01-19"
    due "2015-01-19"
    estimated_hours 1
    fixed false
    rate 1
  end
end
