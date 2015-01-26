# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :time_entry do
    start_time "2015-01-26"
    end_time "2015-01-26"
    project nil
    user nil
    task nil
  end
end
