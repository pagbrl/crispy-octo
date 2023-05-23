Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"
  get "/test", to: "application#test"
  get "/up", to: "application#up"

  resources :articles, only: [:show]

  namespace :admin do
    root "base#index"
    resources :articles
    resources :subscribers
  end
end
