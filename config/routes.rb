TinyMon::Application.routes.draw do
  namespace :admin do
    resources :footer_links do
      collection do
        post :sort
      end
    end
    resources :accounts
    resources :users
  end
  match '/admin' => 'admin#index', :as => :admin
  
  resources :accounts do
    resources :sites do
      resources :health_checks do
        resources :steps do
          collection do
            post :sort
          end
        end
        resources :check_runs do
          resources :comments
        end
        resources :comments
      end
      resources :health_check_imports
      resources :deployments
    end
    resources :user_accounts
    
    member do
      post :switch
    end
  end
  
  resources :health_check_templates
  resources :health_check_template_variables
  resources :health_check_template_steps
  resource :health_check_template_step_data, :to => 'health_check_template_step_data'
  resources :health_check_imports
  resources :health_checks do
    collection do
      put :update_multiple
      post :edit_multiple
    end
  end
  
  resources :sites
  match '/deployments/:token' => 'deployments#create', :as => :mark_deployment, :via => :post
  resources :users do
    resources :comments
  end
  resources :password_resets
  resource :settings
  
  match '/login' => 'user_sessions#new', :as => :login, :via => :get
  match '/login' => 'user_sessions#create', :via => :post
  match '/logout' => 'user_sessions#destroy', :as => :logout, :via => :delete
  root :to => 'start#index'
end
