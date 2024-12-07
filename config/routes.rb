Rails.application.routes.draw do
  get "store/index"
  root 'store#index'
  
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
  end
  
  resources :users
  resources :orders
  resources :line_items
  resources :carts
  resources :products do
    get :search, on: :collection
  end
  
  get 'store/index'
  
  get 'register', to: 'registrations#new'
  post 'register', to: 'registrations#create'
end