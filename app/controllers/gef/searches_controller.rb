class Gef::SearchesController < ApplicationController
  def new
    @gef_search = Gef::Search.new
    
  end
  
  def create
    @gef_search = Gef::Search.create!(user_params)
    redirect_to @gef_search
  end
  
  def show
    @gef_search = Gef::Search.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"gef-id-#{params[:gef_pmis_id]}\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end

  end

  private

  def user_params
    params.require(:gef_search).permit(:gef_country_id, :gef_region_id, :primary_biome,
                                       :gef_pmis_id, :wdpa_id, :wdpa_name)
  end
end
