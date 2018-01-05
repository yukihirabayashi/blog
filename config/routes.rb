Rails.application.routes.draw do
  resources :blogs do
    collection do
      post :confirm
    end
  end
  
  root to: 'webpages#index'
  get '/webpages', to:'webpages#index' #追記する
  resources :webpages
end