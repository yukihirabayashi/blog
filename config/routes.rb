Rails.application.routes.draw do
  get 'sessions/new'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  
  root 'top#index'
    resources :webpages do
      collection do 
      end
    end
    resources :users, only: [:new, :create]
    
    resources :blogs do
      collection do
      post :confirm
      end
    end
  
end