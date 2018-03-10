Rails.application.routes.draw do
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end  

  get 'sessions/new'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy]

  root 'top#index'
    resources :webpages do
      collection do 
      end
    end
    
    resources :blogs do
      collection do
      post :confirm
      end
    end
end