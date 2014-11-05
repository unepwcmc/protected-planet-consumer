Rails.application.routes.draw do


  namespace :gef do
    resources :protected_areas
  end

  get '/api/gef/:gef_pmis_id', to: 'api/gef#show', as: 'gef'

  get '/gef/:gef_pmis_id', to: 'gef/protected_area#index', as: 'protected_areas'

end
