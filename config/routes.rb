Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users , :controllers => {:registrations => "registrations"}
  match '/calendar(/:year(/:month))' => 'calendar#index', :as => :calendar, :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}, via: :get
  
  root 'home#index'
  get '/admin' => 'admin/pages#index'
  post '/home/map_search' => 'home#map_search'
  get '/auth/failure' => 'sessions#failure'
  match 'auth/:provider/callback' => 'authentications#create', :via => :get
  match '/oauth/authenticate' => 'authentications#create', :via => :get
  resources :authentications
  match '/feed' => 'feed#index', via: :get
  
  namespace :admin do
    resources :authentications
    resources :events
    resources :eventtypes
    resources :internallinks
    resources :menus do
      collection do 
        post :sort
      end
      member do
        get :reorder
      end
    end
    
    resources :pages
    resources :places
    resources :posts
    resources :randombackgrounds
    resources :spots
    resources :users
  end
  
  resources :comments
  
  resources :events
  resources :forumposts
  resources :pages
  resources :places
  resources :posts
  resources :projects do
    resources :events
    resources :posts do
      resources :comments
    end
    resources :forumposts do
      resources :comments
    end
    resources :users do
      member do
        get :approve
        get :deny
      end
    end
    member do
      get :request
      get :join
      get :leave
    end
  end
  resources :users
end
