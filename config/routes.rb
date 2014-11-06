Rails.application.routes.draw do

  namespace :gef do
    resources :protected_areas
  end
  get '/api/gef/:gef_pmis_id', to: 'api/gef#index', as: 'gef_home'

  get '/gef/', to: 'gef#index', as: 'gef'

  get '/gef/area/:gef_pmis_id',  to: 'gef/area#index', as: 'gef_area'

  get '/gef/area/:gef_pmis_id/wdpa_record', to: 'gef/wdpa_record#index', as: 'area_wdpa_records'

  get '/gef/area/:gef_pmis_id/wdpa_record/:wdpa_id', to: 'gef/wdpa_record#show', as: 'area_wdpa_record'
end
