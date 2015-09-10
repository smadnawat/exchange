Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # get '/testing' => 'notifications#testing'

##############################chat controller##########################
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
  post '/unblock_user' => 'chats#unblock_user'

  post '/search_by_similar_reading_pref' => 'chats#search_by_similar_reading_pref'
  post '/search_by_similar_books' => 'chats#search_by_similar_books'
  post '/group_is_delete' => 'chats#group_is_delete'
#==============================================================================

############### web services API controller###########################
  post '/register' =>   'apis#register', as: :register
  post '/login' =>   'sessions#create', as: :login
  delete '/logout' =>   'sessions#destroy', as: :logout
  post '/upload_books'  => 'apis#upload_books', as: :upload_books
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
  get  '/my_library' => 'apis#my_library', as: :my_library
  get  '/potential_mat_profile' => 'apis#potential_mat_profile', as: :potential_mat_profile
  get '/view_my_review' => 'apis#view_my_review', as: :view_my_review
  post '/notification_status' => 'apis#notification_status', as: :notification_status
  get '/invitation_details' => 'apis#invitation_details'
  get '/my_chat_list' => 'apis#my_chat_list'
  post '/create_ratings' => 'apis#create_ratings'
  get '/get_ratings' => 'apis#get_ratings'
  get '/terms_and_conditions' => 'apis#terms_and_conditions', as: :terms_and_conditions
  get '/api_privacy_policy' => 'apis#privacy_policy'
  post '/update_lat_and_long' => 'apis#update_lat_and_long'
#####################################################

  ############### web services my passwords controller###########################
  post '/forgot_password' => 'mypasswords#create'
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
  post '/do_create'    =>   'notifications#do_create', as: 'do_create'
  root :to => 'home#dashboard'
  get '/privacy_policy' => 'home#privacy_policy'
  get '/terms_of_use' => 'home#terms_of_use'
  get '/about_us' => 'home#about_us'
  post '/contact_us' => 'home#contact_us', as: "contact_us"
  get '/thank_you' => 'home#thank_you'
  get  '/my_team' => 'home#my_team'
  get "/download_csv",:to => "home#download_csv",:as => "download_csv"
  get "/update_sign_in_token", :to => "apis#update_sign_in_token", :as => "update_sign_in_token" 
  get '/receive_news_letter/:token'=>'home#receive_news_letter',as:'receive_news_letter'
  get '/unsubscribe/:token' => 'home#unsubscribe' , as: 'unsubscribe'

end
