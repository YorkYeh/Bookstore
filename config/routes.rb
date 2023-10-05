# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  
  root 'books#index'

  namespace :admin do
    resources :books
    resources :coupons,only: %i[index new create destroy]
  end

  resources :orders do
    member do 
      patch :checkout
    end
  end

  namespace :api do
    namespace :v1 do
      resources :orders, only: [] do
        collection do
          patch :add_to_cart
        end

        member do
          delete :remove_to_cart
          patch :select_coupon
        end
      end
    end
  end
  
  # resource :cart, only:[:show, :destroy] do
  #   collection do
  #     post :add, path:'add/:id'
  #   end
  # end
end
