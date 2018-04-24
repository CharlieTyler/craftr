Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # Use custom registrations_controller.rb file to add sign_up_params etc
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Largely non-database driven pages
  root 'static_pages#home'
  get "/about" => "static_pages#about"
  get "/contact" => "static_pages#contact"
  get "/privacy-policy" => "static_pages#privacy"

  get "/search" => "search#search" 
  resources :age_verification, only: [:create]
  resources :email_sign_ups, only: [:create, :destroy]

  # Standard pages
  post "random/product" => "products#random"
  resources :products, only: [:show, :index] do
    resources :reviews, only: [:create, :update, :destroy]
    resources :favourite_products, only: [:create, :destroy]
  end
  get "/me" => "users#profile" 
  resources :distilleries, only: [:show, :index]
  resources :articles, only: [:show, :index]
  resources :authors, only: [:show, :index]
  get 'articles/collections/:tag', to: 'articles#tag', as: :article_tag
  resources :categories, only: [:show, :index]
  resources :recipes, only: [:show, :index] do 
    resources :favourite_recipes, only: [:create, :destroy]
    resources :recipe_comments, only: [:create, :destroy]
  end
  get 'recipes/collections/:tag', to: 'recipes#tag', as: :recipe_tag
  resources :ingredients, only: [:create, :edit, :update, :destroy]

  #checkout routes
  namespace :checkout do
    resources :addresses, only: [:new, :create]
    resources :payments, only: [:new, :create]
    get "/confirmation" => "orders#confirmation"
  end
  #cart
  get "/cart" => "order_items#index"
  resources :order_items, only: [:create, :destroy]
  patch "/order_addresses" => "orders#update_addresses"
  patch "/order_shipping" => "orders#update_shipping"

  # All routes to form part of admin portal
  namespace :admin do
    resources :authors, only: [:new, :create, :edit, :update, :destroy]
    resources :products, only: [:new, :create, :edit, :update, :destroy]
    resources :articles, only: [:new, :create, :edit, :update, :destroy]
    resources :recipes, only: [:new, :create, :edit, :update, :destroy]
    resources :distilleries, only: [:new, :create, :edit, :update, :destroy]
    resources :categories, only: [:new, :create, :edit, :update, :destroy]
    resources :carousel_features, only: [:new, :create, :edit, :update, :destroy]
    get "/edit_features", :controller => "featured_items", :action => "edit"
    patch "/features", :controller => "featured_items", :action => "update"
    put "/features", :controller => "featured_items", :action => "update"
    get "/dashboard", :controller => "static_pages", :action => "dashboard"
  end

  namespace :distiller do
    resources :products, only: [:edit, :update] do
      member do
        patch 'mark_as_out_of_stock'
        put 'mark_as_out_of_stock'
        patch 'mark_as_in_stock'
        put 'mark_as_in_stock'
      end
    end
    resources :order_items, only: [:edit, :update]
    get "/dashboard", :controller => "static_pages", :action => "dashboard"
  end
end
