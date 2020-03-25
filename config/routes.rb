Rails.application.routes.draw do

  get 'friendships/create'
  get 'friendships/index'
  resources :dashboards, only: [:new, :create, :destroy]
  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end
  resources :friendships
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
