# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "MyString"
    description "MyText"
    start_date "2015-01-19"
    due_date "2015-01-19"
    estimated_hours 1
    progress 90
    company

    factory :project_with_milestones_and_tasks do
      transient do
        count 5
      end
      after(:create) do |project, evaluator|
        create_list(:milestone_with_tasks, evaluator.count, project: project)
      end
    end
  end
end
