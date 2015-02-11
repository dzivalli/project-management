# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :time_entry do
    project nil
    user nil
    task nil

    factory :active_time_entry do
      status 'active'
    end
  end
end
