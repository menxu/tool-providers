Rails.application.routes.draw do

  root :to => "home#index"

  devise_for :users, :controllers => {:sessions => "users/sessions", :registrations => "users/registrations", :omniauth_callbacks => "users/omniauth_callbacks"}

  resources :home do
    collection do
      get :index
      get :welcome
      get :search
    end
  end
  

  resources :categories do
    collection do
      get :all
      get :trend
    end
  end
  resources :blogs
  resources :sites

  resources :users, only: [:show] do
    collection do
      post :email_validate
      get :search
    end

    member do
      get :funs
      get :tools
      get :blogs
    end
  end

  resources :avatars, only: [:create]

  resources :messages do
    collection do
      get :count
    end
  end

  resources :funs do
    collection do
      delete :destroy
    end
  end

  namespace :admin do
    resources :users do
      collection do
        get  :change_index
        post :change_pwd
      end
    end
    resources :tools
    resources :categories
    resources :blogs
    resources :sites
    root :to => "dashboard#index"
  end
  namespace :settings do
    resource :profiles, only: [:show, :update]
    resource :passwords, only: [:show, :update]
    resource :notifications, only: [:show, :update]
  end

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.has_role?(:admin) } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
