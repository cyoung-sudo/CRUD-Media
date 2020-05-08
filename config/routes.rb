Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'about', to: 'pages#about'

  get 'users_index', to: 'users#index'
  get 'users_show', to: 'users#show'

  resources :posts

  resources :comments
end 
