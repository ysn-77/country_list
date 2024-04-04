class CountriesController < ApplicationController
  def index
    @countries = Country.all.order(:name)
    if params[:search].present?
      @countries = @countries.search(params[:search])
    end

    respond_to do |format|
      format.html
      format.json { render json: @countries }
    end
  end

  def destroy
    @country = Country.find_by_id(params[:id])
    @country&.soft_delete
    respond_to do |format|
      format.html { redirect_to countries_path }
      format.json { head :no_content }
    end
  end
end
