# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Poster.create(
  name: "REGRET",
  description: "Hard work rarely pays off.",
  price: 89.00,
  year: 2018,
  vintage: true,
  img_url: "https://plus.unsplash.com/premium_photo-1661293818249-fddbddf07a5d"
)

Poster.create(
  name: "FAILURE",
  description: "The key to success is knowing when to give up.",
  price: 72.50,
  year: 2020,
  vintage: false,
  img_url: "https://images.unsplash.com/photo-1497032205916-ac775f0649ae"
)

Poster.create(
  name: "DESPAIR",
  description: "Why try, when you can fail spectacularly?",
  price: 65.99,
  year: 2015,
  vintage: true,
  img_url: "https://images.unsplash.com/photo-1511765224389-d52c0aa8a1fb"
)

Poster.create(
  name: "MISERY",
  description: "Happiness is overrated anyway.",
  price: 99.99,
  year: 2019,
  vintage: false,
  img_url: "https://images.unsplash.com/photo-1497302347632-9046cf9787d9"
)

Poster.create(
  name: "DOUBT",
  description: "Confidence is for the unprepared.",
  price: 54.25,
  year: 2021,
  vintage: false,
  img_url: "https://images.unsplash.com/photo-1504198453319-5ce911bafcde"
)

Poster.create(
  name: "APATHY",
  description: "Why bother when nothing matters?",
  price: 78.45,
  year: 2017,
  vintage: true,
  img_url: "https://images.unsplash.com/photo-1485206412256-701cccdeeef6"
)
