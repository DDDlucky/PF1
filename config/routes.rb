Rails.application.routes.draw do
  get 'chats/show'
  root 'homes#top'
  get 'home/about' => 'homes#about'

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  devise_for :users

  resources :users, only: [:show, :index, :edit, :update] do
    member do
      get :following, :followers
    end
  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]

  get '/search' => 'search#search'

  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]

  get 'rakuten_search' => 'search#index'
end
