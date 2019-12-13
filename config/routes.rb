Rails.application.routes.draw do


  #devise routes
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }


  #implementing RESTful resources
  resources :posts do
    resources :like, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  #root is set to the index page of posts
  get 'like/create'
  get 'like/destroy'
  root 'posts#index'
  get 'my_posts', to:'posts#index_user_specific'
  get 'liked_posts', to:'posts#index_liked_posts'
  get 'contact', to:'home#contact'
  post 'request_contact', to: 'home#request_contact'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
