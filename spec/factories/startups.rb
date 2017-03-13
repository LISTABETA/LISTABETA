FactoryGirl.define do
  factory :startup do
    association :user
    sequence(:slug) { |n| "startup-#{n}" }
    sequence(:name) { |n| "Startup #{n}" }
    city "Porto Alegre"
    pitch "Apenas mais um PITCH da startup"
    state "Rio Grande do Sul"
    website "http://www.google.com.br"
    screenshot File.open(Rails.root.join('spec', 'fixtures', 'cover.png'))
    market_list "Fitness, Food, Startups"
    description "Apenas mais uma DESCRIÇÃO da startup"*5
    demonstration "Apenas mais uma DESCRIÇÃO da de como utilizar"*5

    trait :pending do
      status Status::PENDING
    end

    trait :unapproved do
      status Status::UNAPPROVED
    end

    trait :approved do
      status Status::APPROVED
      approved_at DateTime.now
    end

    trait :published do
      status Status::PUBLISHED
      published_at DateTime.now
    end

    trait :highlighted do
      highlighted true
    end
  end
end
