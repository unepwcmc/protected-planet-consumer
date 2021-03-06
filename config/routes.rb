Rails.application.routes.draw do
  namespace :gef do
    resources :protected_areas
    namespace :api do
      resources :areas, only: :index
    end
    resources :searches
    resources :areas, param: :gef_pmis_id do
      resources :wdpa_records, param: :wdpa_id do
        resources :pame_records, param: :mett_original_uid
      end
    end
  end

  get '/gef/not_found/', :to => redirect('/gef/not_found.html'), as: 'gef_not_found'

  get '/gef/', to: 'gef/searches#new', as: 'gef'

  #get '/gef/areas/:gef_pmis_id',  to: 'gef/area#show', as: 'gef_areas'

  #get '/gef/area/:gef_pmis_id/wdpa-records/:wdpa_id/pame-records', to: 'gef/pame_record#index', as: 'pame_records'

  #get '/gef/area/:gef_pmis_id/wdpa-records/:wdpa_id/pame-records/:mett_original_uid', to: 'gef/pame_record#show', as: 'pame_record'

  namespace :parcc do
    namespace :api do
      resources :protected_areas, only: [:index, :show]
      get '/protected_areas/:id/vulnerability', to: 'protected_areas#vulnerability', as: 'vulnerability'
      get '/protected_areas/:id/suitability_changes', to: 'protected_areas#suitability_changes', as: 'suitability_changes'
    end
    get '/:id', to: 'protected_areas#show', as: 'protected_area'
    get '/:id/vulnerability_table', to: 'protected_areas#vulnerability_table', as: 'vulnerability_table'
    get '/:id/suitability_changes_table', to: 'protected_areas#suitability_changes_table', as: 'suitability_changes_table'
    get '/download/:id', to: 'protected_areas#download', as: 'download'
  end
end
