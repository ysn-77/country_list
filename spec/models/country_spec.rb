require 'rails_helper'

RSpec.describe Country, type: :model do
  let(:country) { Country.new(name: "Test Country", alpha_code_2: "TC", alpha_code_3: "TCT", currency_code: "CCC") }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(country).to be_valid
    end

    it "is invalid without required attributes" do
      country.name = nil
      expect(country).not_to be_valid
    end

    it "is invalid if length of alpha_code_2 is incorrect" do
      country.alpha_code_2 = "A"
      expect(country).not_to be_valid

      country.alpha_code_2 = "AAA"
      expect(country).not_to be_valid
    end

    it "is invalid if length of alpha_code_3 is incorrect" do
      country.alpha_code_3 = "A"
      expect(country).not_to be_valid

      country.alpha_code_3 = "AA"
      expect(country).not_to be_valid
    end

    it "is invalid if length of currency is incorrect" do
      country.currency_code = "C"
      expect(country).not_to be_valid

      country.currency_code = "CCCC"
      expect(country).not_to be_valid
    end
  end

  describe "Scopes" do
    it "returns only non-deleted countries by default" do
      country.save
      country.soft_delete
      expect(Country.all).not_to include(country)
    end

    it "returns countries matching alpha codes or currency" do
      country.save
      expect(Country.search("TC")).to include(country)
      expect(Country.search("TCT")).to include(country)
      expect(Country.search("CCC")).to include(country)
      expect(Country.search("INVALID")).not_to include(country)
    end

     it "can handle case-insensitive search queries" do
      country.save
      expect(Country.search("tc")).to include(country)
      expect(Country.search("tct")).to include(country)
      expect(Country.search("ccc")).to include(country)
    end
  end

  describe "Callbacks" do
    it "upcases alpha_code_2, alpha_code_3, and currency_code before validation" do
      country.alpha_code_2 = "aa"
      country.alpha_code_3 = "aaa"
      country.currency_code = "ccc"
      country.valid?
      expect(country.alpha_code_2).to eq("AA")
      expect(country.alpha_code_3).to eq("AAA")
      expect(country.currency_code).to eq("CCC")
    end
  end

  describe "Soft Delete" do
    it "sets deleted_at attribute to current time when soft deleted" do
      country.save
      country.soft_delete
      expect(country.deleted_at).not_to be_nil
    end

    it "returns true only if country is soft deleted" do
      country.save
      expect(country.deleted?).to be false

      country.soft_delete
      expect(country.deleted?).to be true
    end
  end
end
