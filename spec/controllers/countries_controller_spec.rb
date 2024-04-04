require 'rails_helper'

RSpec.describe CountriesController, type: :controller do
  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "assigns all countries ordered by name to @countries" do
      countryB = create(:country, name: "B")
      countryA = create(:country, name: "A")
      get :index
      expect(assigns(:countries)).to eq([countryA, countryB])
    end

    it "filters countries based on the search query" do
      country1 = create(:country, alpha_code_2: "TC")
      country2 = create(:country)
      get :index, params: { search: "TC" }
      expect(assigns(:countries)).to eq([country1])
    end
  end

  describe "DELETE #destroy" do
    it "soft deletes the specified country" do
      country = create(:country)
      expect(country.deleted?).to be(false)
      delete :destroy, params: { id: country.id }
      expect(country.reload.deleted_at).to be_present
    end

    it "redirects to the index page after deletion" do
      country = create(:country)
      delete :destroy, params: { id: country.id }
      expect(response).to redirect_to(countries_path)
    end

    it "handles non-existent country IDs gracefully" do
      delete :destroy, params: { id: -1 }
      expect(response).to redirect_to(countries_path)
    end
  end
end
