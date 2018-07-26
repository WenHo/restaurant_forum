Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "restaurants#index" 
  resources :restaurants, only: [:index, :show] do
    resources :comments,only: [:create, :destroy]

    # 瀏覽所有餐廳最新動態
    collection do
      get :feeds
      # Top ten
      get :ranking
    end

    
    member do
      get :dashboard
      # 瀏覽個別餐廳 Dashboard,帶入餐廳id
      post :favorite, :like
      post :unfavorite, :unlike
    end
  end
  #追蹤功能
  resources :followships, only:[:create, :destroy]
  resources :friendships, only:[:create, :destroy]
  resources :categories, only: :show
  resources :users, only: [:index ,:show, :edit, :update] do
    member do 
      get :friend_list
    end
  end
  namespace :admin do
  	resources :restaurants
  	resources :categories
  	root "restaurants#index"
  end
end
