Rails.application.routes.draw do
  get 'errors/not_found'

  get 'errors/unacceptable'

  get 'errors/internal_server_error'

  devise_for :users, :controllers => { registrations: 'registrations' }
  # Use custom registrations_controller.rb file to add sign_up_params etc
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Largely non-database driven pages
  root 'static_pages#home'
  get "/about" => "static_pages#about"
  get "/contact" => "static_pages#contact"
  get "/privacy-policy" => "static_pages#privacy"
  get "/deliveries-and-shipping" => "static_pages#deliveries"
  get "/returns-and-refunds" => "static_pages#returns"
  get "/giveaway" => "static_pages#giveaway"

  get "/search" => "search#search" 
  resources :age_verification, only: [:create]
  resources :email_sign_ups, only: [:create, :destroy]

  # Standard pages
  post "random/product" => "products#random"
  resources :products, only: [:show, :index] do
    resources :reviews, only: [:create, :update, :destroy]
    resources :favourite_products, only: [:create, :destroy]
  end
  resources :collections, only: [:show, :index]
  resources :distilleries, only: [:show, :index]
  resources :feedbacks, only: [:new, :create, :destroy]
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

  get "/me" => "users#profile" 
  get "/export-data" => "users#export_data"
  namespace :account do
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :orders, only: [:show, :index]
    resources :sold_items, only: [:show]
  end

  #checkout routes
  #cart
  get "/cart" => "order_items#index"
  post "/quick-add" => "order_items#quick_add"
  namespace :checkout do
    patch "/add_voucher" => "orders#add_voucher"
    put "/add_voucher" => "orders#add_vouchers"
    patch "/update_shipping_method" => "orders#update_shipping"
    put "/update_shipping_method" => "orders#update_shipping"
    get "/address" => "orders#address"
    post "/create_address" => "orders#create_address"
    patch "/update_address" => "orders#update_address"
    put "/update_address" => "orders#update_address"
    get "/payment" => "orders#payment"
    post "/complete" => "orders#complete"
    get "/confirmation" => "orders#confirmation"
    post "/create-payment-intent" => "orders#create_payment_intent"
  end
  resources :order_items, only: [:create, :destroy]

  mount StripeEvent::Engine, at: '/stripe/webhook'

  # All routes to form part of admin portal
  namespace :admin do
    get "/dashboard", :controller => "static_pages", :action => "dashboard"
    get "/reports" => "static_pages#reports"
    get "/product-feed-google" => "static_pages#product_feed_google"
    get "/product-feed-facebook" => "static_pages#product_feed_facebook"
    get "/control-panel" => "static_pages#control_panel"
    patch "/change-distillery", :controller => "static_pages", :action => "change_distillery"
    put "/change-distillery", :controller => "static_pages", :action => "change_distillery"
    resources :authors, only: [:new, :create, :edit, :update, :destroy]
    resources :products, only: [:new, :create, :edit, :update, :destroy]
    resources :articles, only: [:new, :create, :edit, :update, :destroy]
    resources :recipes, only: [:new, :create, :edit, :update, :destroy]
    resources :distilleries, only: [:new, :create, :edit, :update, :destroy]
    resources :users, only: [:index, :edit, :update]
    resources :categories, only: [:new, :create, :edit, :update, :destroy]
    resources :carousel_features, only: [:new, :create, :edit, :update, :destroy]
    resources :vouchers
    resources :feedbacks, only: [:update]
    resources :collections, only: [:new, :create, :edit, :update, :destroy]
    get "/edit_features", :controller => "featured_items", :action => "edit"
    patch "/features", :controller => "featured_items", :action => "update"
    put "/features", :controller => "featured_items", :action => "update"
  end

  namespace :distiller do
    get "/dashboard", :controller => "static_pages", :action => "dashboard"
    get "/reports" => "static_pages#reports"
    get "/transactional_checklist" => "details#transactional_checklist"
    resources :addresses, only: [:new, :create, :edit, :update]


    resources :batches, only: [:create, :show, :index] do
      # For marking auto shipments as shipped
      member do
        patch 'mark_as_shipped'
        put 'mark_as_shipped'
      end
    end

    resources :sold_items, only: [:show, :index] do
      # For marking manual shipped items as shipped
      member do
        patch 'mark_as_shipped'
        put 'mark_as_shipped'
      end
    end
    get "/register-stripe-key", :controller => "details", :action => "register_stripe_key"
    resources :products, only: [:edit, :update] do
      member do
        patch 'mark_as_out_of_stock'
        put 'mark_as_out_of_stock'
        patch 'mark_as_in_stock'
        put 'mark_as_in_stock'
      end
    end
  end

  get "/404", to: "errors#not_found"
  get "/422", to: "errors#unacceptable"
  get "/500", to: "errors#internal_server_error"

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
