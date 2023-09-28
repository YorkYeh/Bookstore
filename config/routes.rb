# frozen_string_literal: true

Rails.application.routes.draw do
  root 'books#index'

  resources :books

  resource :cart, only:[:show, :destroy] do
    collection do
      post :add, path:'add/:id'
    end
  end
  
end
