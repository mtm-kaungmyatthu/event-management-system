# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Clear existing data
Event.destroy_all
User.destroy_all
puts "Cleared existing users and events"

# Seed Users
5.times do |n|
  User.create!(
    email: "user#{n+1}@test.com",
    password: "password1",
    name: Faker::Name.name,
    role: "admin"
  )
end
puts "Seeded #{User.count} users successfully."

# Seed Events
40.times do
  Event.create!(
    name: Faker::Lorem.words(number: 3).join(' ').titleize, # Event name
    date: Faker::Date.forward(days: rand(10..90)), # Future date
    time: Faker::Time.forward(days: 5, period: :day).strftime("%H:%M"), # Random time
    location: "#{Faker::Address.city}, #{Faker::Address.country}", # City and country
    description: Faker::Lorem.paragraph(sentence_count: 2), # Description
    user_id: User.pluck(:id).sample # Assign random user
  )
end
puts "Seeded #{Event.count} events successfully."
