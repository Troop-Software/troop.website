# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
patrol_names =['Blood Hounds', 'Screaming Eagles', 'Black Hawks', 'Morning', 'Wolverines']
positions = %w[Patrol\ Leader Assistant\ senior\ patrol\ leader senior\ patrol\ leader troop\ guide Order\ of\ the\ Arrow\ troop\ representative den\ chief scribe librarian historian quartermaster bugler junior\ assistant\ Scoutmaster chaplain\ aide instructor troop\ webmaster Outdoor\ Ethics\ Guide ]
ranks =['Just Joined', 'Scout', 'Tenderfoot', 'Second Class', 'First Class', 'Star', 'Life', 'Eagle']


if Rails.env.development?
  5.times do |x|
    Scout.create!(name: Faker::Name.name, grade: rand(5..12),
                  birthdate: Faker::Date.between(18.years.ago, 11.years.ago),
                  patrol_id: rand(1..patrol_names.count),
                  rank_id: rand(1..ranks.count),
                  position_id: rand(1..positions.count),
                  email: Faker::Internet.email,
                  phone: '1111111111',
                  joined: Date.today,
                  bsa_id: '123456789'
    )
  end

  10.times do |x|
    User.create!(username: "#{Faker::StarWars.character} #{x}",
                 email: Faker::Internet.email,
                 password: '123456')

  end
  users = User.all
  users.each do |user|
    10.times do |x|
      user.articles.create!(title: Faker::Pokemon.name.truncate(50), description: Faker::Lorem.paragraph(100, false, 8).truncate(1000))
    end
  end
end

