Rails.application.routes.draw do
  resources :charities
  resources :users do
    resources :dares
  end

  post '/donations' => 'donations#create'
  get '/donations' => 'donations#new'

  get '/stripe' => 'dares#stripe'
  get '/home' => 'users#home'
  post '/login' => 'users#login'
  match "/auth/:provider/callback" => "sessions#create", via: [:get, :post]
  get "/signout" => "sessions#destroy", as: :signout


  root 'users#home'


  # Example of regular route:
    get '/users/:user_id/dares/:id/set_price' => 'dares#set_price', as: :set_price
    put '/users/:user_id/dares/:id/set_price' => 'dares#put_price', as: :put_price


  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
