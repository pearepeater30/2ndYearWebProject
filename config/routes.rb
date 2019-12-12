Rails.application.routes.draw do
  get 'like/create'
  get 'like/destroy'

  #devise routes
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  get 'myposts', to:'posts#index_user_specific'

  #implementing RESTful resources
  resources :posts do
    resources :like, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  #root is set to the index page of posts
  root 'posts#index'
  #
  get 'contact', to:'home#contact'
  post 'request_contact', to: 'home#request_contact'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
