# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    password '12345'
    password_confirmation '12345'
    email { "#{Devise.friendly_token.first(5)}@email.ru" }
    full_name 'name surname'

    factory :admin do
      association :role, factory: :admin_role
    end

    # factory :client do
    #   association :role, factory: :client_role
    # end

    factory :staff do
      association :role, factory: :staff_role
    end

  end
end
