Rails.application.routes.draw do

  namespace :gef do
    resources :protected_areas
    namespace :api do
      resources :area, only: :index
    end
  end

  get '/gef/', to: 'gef#index', as: 'gef'

  get '/gef/area/:gef_pmis_id',  to: 'gef/area#show', as: 'gef_area'

  get '/gef/area/:gef_pmis_id/wdpa-record/:wdpa_id/pame-record', to: 'gef/pame_record#index', as: 'pame_records'

  get '/gef/area/:gef_pmis_id/wdpa-record/:wdpa_id/pame-record/:mett_original_uid', to: 'gef/pame_record#show', as: 'pame_record'
end
