# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  
  root 'books#index'
  
  resources :books, only: [:index]

  namespace :admin do
    resources :books
    resources :coupons,only: %i[index new create destroy]
  end

  resource :cart, only:[:show, :destroy] do
    collection do
      post :add, path:'add/:id'
    end
  end
  
end
