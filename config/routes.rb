Rails.application.routes.draw do
  root 'home#index'
  get 'unpaid', controller: 'home'

  devise_for :users, skip: [:passwords]

  resources :clients

  resources :permissions, only: [:index]
  resources :users do
    resources :permissions, only: [:new, :create]
    get 'password', on: :member
  end

  resources :companies do
    resources :invoices, only: :new
    resources :projects, only: :new
    resources :users, only: [:new] do
      get 'primary', on: :member
    end
  end

  resources :profile, only: [:index, :update]

  resources :messages
  resources :tickets do
    resources :ticket_replies
  end

  resources :templates, only: [:index]
  resources :task_templates, :milestone_templates, :item_templates, :email_templates

  resources :payments, except: [:new, :create] do
    member do
      get 'result'
      get 'success'
      get 'fail'
    end
  end
  resources :invoices do
    resources :payments, only: [:new, :create]
    resources :items
    member do
      get 'pdf'
      get 'notice'
      get 'pay'
    end
  end

  resources :plans
  resources :default_emails

  # TODO constrain all routes
  resources :projects do
    resources :milestones do
      get 'templates', on: :collection
    end
    resources :tasks do
      get 'templates', on: :collection
    end
    resources :time_entries
    resources :attachments
    resources :histories, only: [:index]
    resources :team, only: [:index, :new, :create]
    resources :permissions, only: [:new, :create]
    member do
      get 'invoice'
      get 'copy'
      # get 'permissions'
      # post 'permissions', action: 'update_permissions'
    end
  end



  #  routes for setting controller
  get 'settings/general'
  get 'settings/email'
  patch 'settings/update'
end
