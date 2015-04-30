Rails.application.routes.draw do
  devise_for :user
  root 'users#index'

  get 'friends/index' => 'friends#index'

  post 'friendships/create' => 'friendships#create'
  delete 'friendships/destroy' => 'friendships#destroy'

  get 'requests/index' => 'requests#index'
  post 'requests/create' => 'requests#create'
  delete 'requests/destroy' => 'requests#destroy'

  resources :users do
    resources :posts
    collection do
      get 'search'
    end
  end
end
