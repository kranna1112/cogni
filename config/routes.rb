require 'constraints/subdomain_required'

Rails.application.routes.draw do

  authenticated :user do
    resources :users, only: [:profile, :update_profile, :switch] do
      member do
        get :profile
        put :update_profile
      end
      collection do
        put :switch
      end
    end
  end

  devise_for :users, skip: :registrations

  constraints(Constraints::SubdomainRequired) do
    constraints subdomain: 'admin' do
      scope module: :admin, as: 'admin' do
        resources :users do
          get 'delete'
        end
        resources :organizations
        resources :service_types
        root to: 'home#administration', as: :dashboard
      end
    end

    constraints subdomain: 'cognizant' do
      scope module: :cognizant, as: 'cognizant' do
        resources :relocations, only: [:show, :update, :edit] do
          resources :steps, only: [:show, :update]
          member do
            get 'dashboard'
          end
        end
        resources :employees, only: [:show, :update, :edit]
      end
    end

    constraints subdomain: 'api' do
      scope module: :api, defaults: {format: :json} do
        namespace :cognizant do
          namespace :v1 do
            resources :relocations, only: [:new, :create, :index, :show]
          end
        end
      end
    end
  end

  resources :organizations, only: [:show], shallow: true do
    resources :employees, controller: 'organizations/employees', only: [:index, :new, :create]
    resources :policies, controller: 'organizations/policies', only: [:index, :new, :create, :edit, :update, :show]
    resources :relocations, controller: 'organizations/relocations', only: [:index, :new, :create]
    resources :users, controller: 'organizations/users', only: [:index, :new, :create]
    resources :relationships, controller: 'organizations/relationships', only: [:index]
    resources :memberships, controller: 'organizations/memberships', only: [:index, :new, :create]
    resources :policy_steps, only: [:new, :create]
    member do
      get :dashboard
    end
  end

  resources :relocations, only: [:index, :show], shallow: true do
    resources :service_requests, controller: 'relocations/service_requests', only: [:index, :show, :new, :create]
    resources :service_orders, controller: 'relocations/service_orders', only: [:index, :show, :new, :create]
  end

  resources :employees, only: [:show, :edit, :update]
  resources :bundles
  resources :properties


  root 'home#index'

end
