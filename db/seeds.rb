# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.all.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('users') 
Event.all.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('events') 


10.times do
  User.create(first_name: Faker::TvShows::Buffy.character,last_name: Faker::TvShows::Buffy.character,
  email: "#{Faker::Name.last_name}@yopmail.com", description: Faker::TvShows::Buffy.quote,
  encrypted_password:rand(1..10) )
end

t1 = Time.parse("2019-11-03 14:40:34")
t2 = Time.parse("2022-01-01 00:00:00")

nb_events=20

nb_events.times do |x|
  Event.create(
    start_date: rand(t1..t2),
    duration: rand(5..10)*5,
    description: Faker::Lorem.paragraph_by_chars(number: 300, supplemental: false),
    location: Faker::Address.city,
    price: rand(1..1000),
    title: Faker::Book.title,
    user_id: User.all.sample.id)
  puts "Seeding of Event nb #{x}"
end