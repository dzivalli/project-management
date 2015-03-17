# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    password '12345'
    password_confirmation '12345'
    sequence(:email) { |n| "user_#{n}}@email.ru" }
    full_name 'name surname'
    sequence(:confirmation_token) { |n| "token#{n}" }

    factory :admin do
      association :role, factory: :admin_role
    end

    factory :root do
      association :role, factory: :root_role
    end

    factory :staff do
      association :role, factory: :staff_role
    end

  end
end
