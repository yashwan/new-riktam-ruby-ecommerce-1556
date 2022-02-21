Rails.application.routes.draw do
  root "sessions#new"
  get "/pages" => "pages#home"
  get "/view/:film_id/:id" => "pages#view"
  get "/cart/:film_id/:id/:title/:cost" => "pages#cart"
  get "/delcart/:id/:uid" => "pages#delcart"
  get "/delbuy/:id/:uid" => "pages#delbuy"
  get "/buy/:film_id/:id/:title/:cost/:cartid" => "pages#buy"
  get 'carts/:id' => 'pages#carts'
  get 'buys/:id' => 'pages#buys'
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  resources :users, except: [:new]
end
