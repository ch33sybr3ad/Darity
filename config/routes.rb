 Rails.application.routes.draw do

  resources :comments

  resources :generate_dares, only: :generate
  resources :charities, only: :index
  resources :pending_dares, only: [:show, :create]

  resources :users do
    resources :dares
    resources :relationships, only: [:create, :destroy]
  end

  resources :account_activations, only: [:edit]

  root 'users#home'

  get '/feed' => 'users#feed', as: :feed

  get '/home' => 'users#home'
  get '/about' => 'users#about'
  post '/login' => 'sessions#login'
  match "/auth/:provider/callback" => "sessions#create", via: [:get, :post]
  get "/signout" => "sessions#destroy", as: :signout

  get '/generate' => "generate_dares#generate", as: :generate

  get '/users/:user_id/dares/:id/set_price' => 'dares#set_price', as: :set_price
  patch '/users/:user_id/dares/:id/set_price' => 'dares#put_price', as: :put_price

  get '/dares/:dare_id/video/new' => 'videos#new', as: :new_video
  post '/dares/:dare_id/video' => 'videos#create', as: :dare_videos

  get '/dares/:dare_id/donations/:id/pay' => 'donations#pay', as: :pay_donations
  post '/dares/:dare_id/donations/:id/pay' => 'donations#paid'
  get '/dares/:dare_id/donations/new' => 'donations#new', as: :new_donation
  post '/dares/:dare_id/donations' => 'donations#create', as: :donations

  patch '/dares/:dare_id/donations/approve' => "dares#approve", as: :approve

  patch '/dares/:dare_id/donations/disapprove' => "dares#disapprove", as: :disapprove

  post '/comments/:id/upvote' => 'comments#upvote', as: :upvote
  post '/comments/:id/downvote' => 'comments#downvote', as: :downvote

  get 'account_activations/edit'

  get '/users/invite/:handle' => "users#new_invite"

  get '/check_handle/:handle' => "users#check", as: :check


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
