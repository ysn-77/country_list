# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

countries = [
  { name: 'Australia', alpha_code_2: 'AU', alpha_code_3: 'AUS', currency_code: 'AUD' },
  { name: 'Netherlands', alpha_code_2: 'NL', alpha_code_3: 'NLD', currency_code: 'EUR' },
  { name: 'South Africa', alpha_code_2: 'ZA', alpha_code_3: 'ZAF', currency_code: 'ZAR' },
  { name: 'Spain', alpha_code_2: 'ES', alpha_code_3: 'ESP', currency_code: 'EUR' },
  { name: 'United Kingdom', alpha_code_2: 'GB', alpha_code_3: 'GBR', currency_code: 'GBP' },
  { name: 'United States of America', alpha_code_2: 'US', alpha_code_3: 'USA', currency_code: 'USD' }
]

countries.each do |country|
  Country.find_or_create_by(country)
end
