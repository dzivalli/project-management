# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    name "MyString"
    description "MyText"
    start_date "2015-01-26"
    due_date "2015-01-26"
    project nil
    milestone nil
    visible false
    progress 1
    added_by nil
    auto_progress false
  end
end
