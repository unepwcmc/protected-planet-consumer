Rails.application.routes.draw do

  namespace :api do
    resources :gef, only: :index
  end

  namespace :gef do
    resources :protected_areas
  end

  get '/gef/', to: 'gef#index'

  get '/gef/:gef_pmis_id', to: 'gef/protected_area#index', as: 'protected_areas'
  get '/gef/:gef_pmis_id/wdpa/:wdpa_id', to: 'gef/protected_areas#show', as: 'wdpa_protected_area' 

end
