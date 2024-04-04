class CountriesController < ApplicationController
  def index
    @countries = Country.all.order(:name)
    if params[:search].present?
      @countries = @countries.search(params[:search])
    end
  end

  def destroy
    @country = Country.find_by_id(params[:id])
    @country&.soft_delete
    redirect_to countries_path
  end
end
