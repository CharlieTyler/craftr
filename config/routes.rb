Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Largely non-database driven pages
  root 'static_pages#home'
  get "/about", :controller => "static_pages", :action => "about"

  # Standard pages
  resources :products, only: [:show, :index] do
    resources :reviews, only: [:create, :update, :destroy]
  end
  resources :distilleries, only: [:show, :index]
  resources :categories, only: [:show]
  resources :recipes do
    resources :favourite_recipes, only: [:create, :destroy]
    resources :recipe_comments, only: [:create, :destroy]
  end
  resources :ingredients, only: [:create]

  # All routes to form part of admin portal
  namespace :admin do
    resources :products, only: [:new, :create, :edit, :update, :destroy]
    resources :distilleries, only: [:new, :create, :edit, :update, :destroy]
    resources :categories, only: [:new, :create, :edit, :update, :destroy]
  end
end
