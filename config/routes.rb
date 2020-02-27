Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "welcome#index"

  get "/merchants", to: "merchants#index"
  get "/merchants/new", to: "merchants#new"
  get "/merchants/:id", to: "merchants#show"
  post "/merchants", to: "merchants#create"
  get "/merchants/:id/edit", to: "merchants#edit"
  patch "/merchants/:id", to: "merchants#update"
  delete "/merchants/:id", to: "merchants#destroy"

  get "/items", to: "items#index"
  get "/items/:id", to: "items#show"
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
  get "/merchants/:merchant_id/items", to: "items#index"

  get "/items/:item_id/reviews/new", to: "reviews#new"
  post "/items/:item_id/reviews", to: "reviews#create"

  get "/reviews/:id/edit", to: "reviews#edit"
  patch "/reviews/:id", to: "reviews#update"
  delete "/reviews/:id", to: "reviews#destroy"

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  post "/cart", to: "cart#increment_decrement"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"

  get "/orders/new", to: "orders#new"
  post "/orders", to: "orders#create"
  get "/orders/:id", to: "orders#show"

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/profile/edit', to: 'users#edit'
  patch '/profile', to: 'users#update'
  get '/profile', to: 'users#show'

  get '/password/edit', to: 'password#edit'
  patch '/password', to: 'password#update'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/profile/orders', to: 'user_orders#index'
  get '/profile/orders/:order_id', to: 'user_orders#show'
  delete '/profile/orders/:order_id', to: 'user_orders#destroy'

  namespace :merchant do
    get '/', to: 'dashboard#show'
    post '/items/:item_id', to: 'items#activate_deactivate_item'
    patch '/orders/:order_id/item_order/:item_order_id', to: "orders#fulfill"
    resources :items do
    end
    resources :orders, only: [:show] do
    end
  end

  namespace :admin do
    get '/', to: 'dashboard#index'
    get '/users', to: 'users#index'
    get '/users/:id', to: 'users#show'
    patch '/orders/:order_id', to: 'dashboard#update'
    get '/merchants/:merchant_id', to: 'merchants#show'
    get '/merchants', to: 'merchants#index'
    patch '/merchants/:merchant_id', to: 'merchants#enable_disable_merchant'
  end
end
