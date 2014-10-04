Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users , :controllers => {:registrations => "registrations"}

  root 'home#index'
  get '/admin' => 'admin/pages#index'
  
  get '/auth/failure' => 'sessions#failure'
  match 'auth/:provider/callback' => 'authentications#create', :via => :get
  match '/oauth/authenticate' => 'authentications#create', :via => :get
  resources :authentications
  
  namespace :admin do
    resources :menus do
      collection do 
        post :sort
      end
      member do
        get :reorder
      end
    end
    
    resources :pages
    
  end
  
  resources :pages
  
end
