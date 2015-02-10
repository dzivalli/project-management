# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :milestone do
    name "MyString"
    description "MyText"
    start_date "2015-01-26"
    due_date "2015-01-26"

    factory :milestone_with_tasks do
      transient do
        count 5
      end

      after(:create) do |milestone, evaluator|
        create_list(:task, evaluator.count, milestone: milestone)
      end
    end
  end
end
