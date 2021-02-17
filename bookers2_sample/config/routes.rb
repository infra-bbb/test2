Rails.application.routes.draw do
  root to: 'homes#top'
  get 'home/about', to: 'homes#about'
  devise_for :users
  resources :users, except: [:create, :new, :destroy] do
    resource :relationships, only: [:create, :destroy]
    get 'following', to: 'relationships#following'
    get 'follower', to: 'relationships#follower'
  end
  resources :books, except: [:new] do
    resource :favorites, only: [:create, :destroy]
  end
  resources :comments, only: [:index, :create, :destroy]
  resources :searches, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
