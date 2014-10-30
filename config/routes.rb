Rails.application.routes.draw do

  namespace :api do
    resources :gef, only: :index
  end

  namespace :gef do
    resources :protected_areas
  end

  get '/gef/:gef_pmis_id', to: 'gef/protected_area#index', as: 'protected_areas'

end
