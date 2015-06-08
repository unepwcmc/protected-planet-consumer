class Gef::SearchesController < GefController
  def new
    @gef_search = Gef::Search.new
  end
  
  def create
    check_params = user_params.values.map{ |param| true if not param.blank? }
    if check_params.include? true
      @gef_search = Gef::Search.create!(user_params)
      redirect_to @gef_search
    else
      redirect_to '/gef/not_found'
    end
  end
  
  def show
    @gef_search = Gef::Search.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"search-results.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end


  private

  def user_params
    params.require(:gef_search).permit(:gef_country_id, :gef_region_id, :primary_biome_id,
                                       :gef_pmis_id, :wdpa_id, :wdpa_name)
  end
end
