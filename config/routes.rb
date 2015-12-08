Rails.application.routes.draw do
  
  devise_for :users, controllers: (sessions: "users")
  root 'users#index'

  get 'friends/index' => 'friends#index'
  patch 'friends/index' => 'friends#index'
  
  post 'friendships/create' => 'friendships#create'
  # patch 'friendships/update' => 'friendships#update'
  # put 'friendships/update' => 'friendships#update'
  delete 'friendships/destroy' => 'friendships#destroy'

  get 'requests/index' => 'requests#index'
  post 'requests/create' => 'requests#create'
  delete 'requests/destroy' => 'requests#destroy'


  resources :friendships, only: [:update]
  resources :circles
  resources :users do
    resources :posts do
      member do
        put 'like' => 'posts#upvote'
      end
      resources :comments
    end 
    collection do
      get 'search'
    end
  end
end
