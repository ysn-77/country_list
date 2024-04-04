require 'rails_helper'

RSpec.feature "Countries", type: :feature do

  scenario "User visits the countries index page" do
    country = create(:country)
    visit countries_path
    expect(page).to have_content(country.name)
    expect(page).to have_content(country.alpha_code_2)
    expect(page).to have_content(country.alpha_code_3)
    expect(page).to have_content(country.currency_code)
    expect(page).to have_link("Delete", href: country_path(country))
  end

  scenario "User deletes a country" do
    country = create(:country)
    visit countries_path
    click_link "Delete"
    expect(page).not_to have_content(country.name)
  end

  scenario "User searches for a country by alpha_code" do
    country = create(:country)
    visit countries_path

    expect(page).to have_content(country.name)
    expect(page).to have_content(country.alpha_code_2)
  end

  scenario "User searches for a country" do
    country1 = create(:country)
    country2 = create(:country)

    visit countries_path
    fill_in "search", with: country1.alpha_code_2
    click_button "Search"

    expect(page).to have_content(country1.name)
    expect(page).not_to have_content(country2.name)
  end

  scenario "User searches for a country that isn't present" do
    country1 = create(:country, alpha_code_2: "US", alpha_code_3: "USA", currency_code: "USD")
    country2 = create(:country, alpha_code_2: "CA", alpha_code_3: "CAN", currency_code: "CAD")

    visit countries_path
    fill_in "search", with: "UK"
    click_button "Search"

    expect(page).to have_content(I18n.t('countries.index.no_countries_found'))
  end
end
