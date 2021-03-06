Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :books, only: [:show] do
    resources :comments, only: :create
  end
  resources :likes, only: [:destroy, :create]

  resources :groups, only: [:new, :create, :show] do
    resources :books, only: [:new, :create]
    resources :movies, only: [:new, :create]
    resources :games, only: [:new, :create]
    resources :series, only: [:new, :create]
    resources :members, only: [:new, :create]
  end
  resources :users, only: [:edit, :update]
end
