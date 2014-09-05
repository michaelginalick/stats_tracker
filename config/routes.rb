Rails.application.routes.draw do


  # You can have the root of your site routed with "root"
  root 'user#index'

  #create user routes
  resources :user
  #sessions routes
  post '/session/login' => 'session#login'
  get '/session/logout' => 'session#logout', :as => 'logout'

  resources :team do
    resources :stats
  end

  resources :season do
    resources :games
  end

end
