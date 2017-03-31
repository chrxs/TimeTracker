FactoryGirl.define do
  factory :weekday_setting do
    sequence(:day_of_week) { |n| "day of the week {n}" }
    required_minutes_logged 480
  end

  factory :user do
    sequence(:email) { |n| "email_#{n}@example.com" }
    password '12345678'
  end

  factory :admin_user, class: User do
    sequence(:email) { |n| "email_#{n}@example.com" }
    password '12345678'
    is_admin true
  end

  factory :project do
    sequence(:name) { |n| "example_project #{n}" }
  end

  factory :day do
    date Date.today
  end
end
