Rails.application.routes.draw do
#chat controller
  post '/chat_exchange' => 'chats#chat_exchange'
  post '/accept_decline' => 'chats#accept_decline'
  post '/get_notification_list' => "chats#get_notification_list"
  post '/get_notification_detail' => "chats#get_notification_detail"
#===========================================

  post '/register'          =>   'apis#register', as: :register
  post '/login'             =>   'sessions#create', as: :login
  delete '/logout'            =>   'sessions#destroy', as: :logout
  post '/upload_books'      => 'apis#upload_books', as: :upload_books
  get  '/get_uploaded_books' => 'apis#get_uploaded_books', as: :get_uploaded_books
  post  '/upload_reading_preferences' => 'apis#upload_reading_preferences', as: :upload_reading_preferences
  get  '/my_reading_preferences' => 'apis#my_reading_preferences', as: :my_reading_preferences
  get  '/my_reading_preferences_for_author' => 'apis#my_reading_preferences_for_author', as: :my_reading_preferences_for_author
  get  '/my_reading_preferences_for_genre' =>  'apis#my_reading_preferences_for_genre', as: :my_reading_preferences_for_genre
  get  '/user_profile'  => 'apis#user_profile', as: :user_profile
  put  '/update_profile'  => 'apis#update_profile', as: :update_profile
  get  '/search_potential_matches' => 'apis#search_potential_matches', as: :search_potential_matches
  
#My password controller =========================
  post '/forgot_password' => 'mypasswords#create'
  get '/change_password/:reset_password_token' => 'mypasswords#edit', as: :change_password
  post '/update' => 'mypasswords#update', as: :update_password
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  get '/users/block:id' => 'users#block',as: 'block'
  resources :banners
  resources :notifications
  post 'notifications/popup'=> 'notifications#popup'
  get '*notfound'         => 'notifications#notfound'
  post '/do_create'    =>   'notifications#do_create', as: 'do_create'
  root :to => 'notifications#welcome'

end
