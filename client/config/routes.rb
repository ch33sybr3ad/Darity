Rails.application.routes.draw do

  resources :charities

  resources :users do
    resources :dares do 
    end
  end

  get '/home' => 'users#home'
  post '/login' => 'users#login'
  match "/auth/:provider/callback" => "sessions#create", via: [:get, :post]
  get "/signout" => "sessions#destroy", as: :signout

  root 'users#home'

  get '/users/:user_id/dares/:id/set_price' => 'dares#set_price', as: :set_price
  patch '/users/:user_id/dares/:id/set_price' => 'dares#put_price', as: :put_price

  get '/dares/:dare_id/video/new' => 'videos#new', as: :new_video
  post '/dares/:dare_id/video' => 'videos#create', as: :dare_videos

  get '/dares/:dare_id/donations/:id/pay' => 'donations#pay', as: :pay_donations
  post '/dares/:dare_id/donations/:id/pay' => 'donations#paid'
  get '/dares/:dare_id/donations/new' => 'donations#new', as: :new_donation
  post '/dares/:dare_id/donations' => 'donations#create', as: :donations

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
