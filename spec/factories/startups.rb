FactoryGirl.define do
  factory :startup do
    name { "Startup de teste" }
    city { "Porto Alegre" }
    email { "startup@test.com" }
    pitch { "Apenas mais um PITCH da startup" }
    state { "Rio Grande do Sul" }
    status { Status::PENDENT }
    website { "http://www.google.com.br" }
    screenshot { File.open(Rails.root.join('spec', 'fixtures', 'photo.png')) }
    highlighted { false }
    market_list { "Fitness, Food, Startups" }
    description { "Apenas mais uma DESCRIÇÃO da startup" }
  end
end
