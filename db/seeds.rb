# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |i|
  User.create!(name: "User #{i}",
               email: "user_#{i}@test.com",
               avatar: File.open(Rails.root.join('spec', 'fixtures', 'photo.png')),
               password: "123123123")
end

10.times do |i|
  user = User.order('RANDOM()').first
  Startup.create!(user: user,
                  name: "Startup de teste #{i}",
                  website: "http://www.startup.com.br",
                  pitch: "Apenas mais um PITCH da startup",
                  description: "Apenas mais uma DESCRIÇÃO da startup 3hu21hu321uh32uh1",
                  screenshot: File.open(Rails.root.join('spec', 'fixtures', 'photo.png')),
                  state: "Rio Grande do Sul",
                  city: "Porto Alegre",
                  market_list: "Fitness#{i}, Food#{i}, Startups#{i}",
                  highlighted: false,
                  published_at: DateTime.now,
                  demonstration: "SAU HSUAH USHAUH SUAH UHSAUH SAUH USAHU HSAUA",
                  status: Status::PUBLISHED)
end
