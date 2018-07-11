Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/portfolios/user/:id', to: 'portfolios#user'
  resources :assets
  resources :portfolios
end
