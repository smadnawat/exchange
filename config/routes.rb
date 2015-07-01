Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

 ############### web services API controller###########################
#chat controller
  post '/chat_exchange' => 'chats#chat_exchange'
  post '/accept_decline' => 'chats#accept_decline'
  post '/get_notification_list' => "chats#get_notification_list"
  post '/get_notification_detail' => "chats#get_notification_detail"
  post '/group_chat' => 'chats#group_chat'
  get '/get_chat' => 'chats#get_chat'
  get '/group_detail' => 'chats#group_detail'
  post '/block_users' => 'chats#block_users'
  post '/search_user' => 'chats#search_user'
  post '/add_user_to_group' => 'chats#add_user_to_group'

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
  post  '/delete_uploaded_books' => 'apis#delete_uploaded_books', as: :delete_uploaded_books
  post  '/delete_reading_preferences' => 'apis#delete_reading_preferences', as: :delete_reading_preferences
  post  '/deactivate_books_from_rp' => 'apis#deactivate_books_from_rp', as: :deactivate_books_from_rp
  post  '/deactivate_authors_from_rp' => 'apis#deactivate_authors_from_rp', as: :deactivate_authors_from_rp
  post  '/deactivate_genres_from_rp' => 'apis#deactivate_genres_from_rp', as: :deactivate_genres_from_rp
  post  '/delete_author_name' => 'apis#delete_author_name', as: :delete_author_name
  post  '/delete_genre_name' => 'apis#delete_genre_name', as: :delete_genre_name
  post  '/author_search' => 'apis#author_search', as: :author_search
  post  '/genre_search' => 'apis#genre_search', as: :genre_search
  post  '/upload_book_title_search' => 'apis#upload_book_title_search', as: :upload_book_title_search
  post  '/upload_book_author_search' => 'apis#upload_book_author_search', as: :upload_book_author_search
  post  '/scanning_isbn' => 'apis#scanning_isbn', as: :scanning_isbn
  post  '/reading_prf_searching' =>  'apis#reading_prf_searching', as: :reading_prf_searching
  get  '/get_advertisement' => 'apis#get_advertisement', as: :get_advertisement
  post '/upload_multiple_reading_pref'=>'apis#upload_multiple_reading_pref', as: :upload_multiple_reading_pref
  post  '/upload_by_scanning_counts' => 'apis#upload_by_scanning_counts', as: :upload_by_scanning_counts
  get '/invitation_details' => 'apis#invitation_details'
  get '/my_chat_list' => 'apis#my_chat_list'
  post '/create_ratings' => 'apis#create_ratings'
  get '/get_ratings' => 'apis#get_ratings'
  #####################################################

  ############### web services my passwords controller###########################
  post '/forgot_password' => 'mypasswords#create'
  #get '/change_password/:reset_password_token' => 'mypasswords#edit', as: :change_password
  post '/update' => 'mypasswords#update', as: :update_password
   #####################################################
  # post '/create_ratings' => 'apis#create_ratings'
  # get '/get_ratings' => 'apis#get_ratings'
  
#My password controller =========================
  #post '/forgot_password' => 'mypasswords#create'
  #get '/change_password/:reset_password_token' => 'mypasswords#edit', as: :change_password
  #post '/update' => 'mypasswords#update', as: :update_password
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
  #get '*notfound'         => 'notifications#notfound'
  post '/do_create'    =>   'notifications#do_create', as: 'do_create'
  root :to => 'notifications#welcome'

end
