# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    name "MyString"
    description "MyText"
    due_date "2015-01-26"
    progress 1

    factory :active_tasks do
      association :time_entry, status: 'active', user: user
    end

  end
end
