# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  
  root 'home#index'

  resources :books

  resource :cart, only:[:show, :destroy] do
    collection do
      post :add, path:'add/:id'
    end
  end
  
end
