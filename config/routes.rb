Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"
  
  resources :articles, only: [:show]

  namespace :admin do
    root "base#index"
    resources :articles
    resources :subscribers
  end
  match '*path', to: 'application#redirect_to_home', via: :all

end
