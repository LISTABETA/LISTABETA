FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Usuário de teste #{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    avatar { File.open(Rails.root.join('spec', 'fixtures', 'avatar.png')) }
    password '123123123'

    trait :confirmed do
      confirmed_at 1.day.ago
    end

    trait :unconfirmed do
      confirmed_at nil
    end
  end
end
