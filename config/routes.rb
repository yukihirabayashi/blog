Rails.application.routes.draw do
  root to: 'top#index'
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