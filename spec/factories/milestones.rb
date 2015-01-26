# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :milestone do
    name "MyString"
    description "MyText"
    start_date "2015-01-26"
    due_date "2015-01-26"
    project nil
  end
end
