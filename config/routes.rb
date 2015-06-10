Rails.application.routes.draw do
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
  post '/register'  =>   'apis#register'
  post '/login'     =>   'sessions#create'
  post '/logout'    =>   'sessions#destroy'

   get '*notfound'         => 'notifications#notfound'
  post '/do_create'    =>   'notifications#do_create', as: 'do_create'

end
