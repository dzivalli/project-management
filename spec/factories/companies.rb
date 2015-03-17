# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    sequence(:name) { |n| "company_#{n}"}
    sequence(:email) { |n| "company_email_#{n}@ru.ru"}
    address "MyString"
    city "MyString"
    website "MyString"
    client nil
  end
end
