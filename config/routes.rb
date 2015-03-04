Rails.application.routes.draw do
   root 'home#index'

  # get 'home/index'

  devise_for :users, skip: [:passwords]

  resources :clients

  resources :users do
    get 'password', on: :member
  end

  resources :companies do
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
      get 'pay'
      get 'result'
      get 'success'
      get 'fail'
    end
  end
  resources :invoices do
    resources :payments, only: [:new, :create]
    resources :items
    get 'pdf', on: :member
    get 'notice', on: :member
  end

  # resources :payments

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
    member do
      get 'team'
      get 'permissions'
      post 'permissions', action: 'update_permissions'
    end
  end



  #  routes for setting controller
  get 'settings/general'
  get 'settings/email'
  patch 'settings/update'


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
