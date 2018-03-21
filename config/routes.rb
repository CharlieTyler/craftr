Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Largely non-database driven pages
  root 'static_pages#home'
  get "/about" => "static_pages#about"
  get "/contact" => "static_pages#contact"

  get "/search" => "search#search" 

  # Standard pages
  post "random/product" => "products#random"
  resources :products, only: [:show, :index] do
    resources :reviews, only: [:create, :update, :destroy]
    resources :favourite_products, only: [:create, :destroy]
  end
  get "/me" => "users#profile" 
  resources :distilleries, only: [:show, :index]
  resources :articles, only: [:show, :index]
  resources :categories, only: [:show]
  resources :recipes do 
    resources :favourite_recipes, only: [:create, :destroy]
    resources :recipe_comments, only: [:create, :destroy]
  end
  resources :ingredients, only: [:create]

  # All routes to form part of admin portal
  namespace :admin do
    resources :products, only: [:new, :create, :edit, :update, :destroy]
    resources :articles, only: [:new, :create, :edit, :update, :destroy]
    resources :distilleries, only: [:new, :create, :edit, :update, :destroy]
    resources :categories, only: [:new, :create, :edit, :update, :destroy]
    get "/dashboard", :controller => "static_pages", :action => "dashboard"
  end
end
