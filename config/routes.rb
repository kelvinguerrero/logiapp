Rails.application.routes.draw do

  resources :bill_movements do
    collection do

      get 'bill_transaction', :action => 'bill_transaction', :as => 'transaction'
    end


  end

  resources :type_movements

  resources :sales

  resources :concepts

  resources :client_taxes

  resources :invoices do
    collection do
      get 'preinvoice'
      get 'listinvoice'
    end
      get 'pay'
  end

  resources :parameters

  resources :logi_bills

  resources :movements

  resources :boxes

  resources :outflows

  resources :drivers

  resources :middlemen

  resources :cars

  resources :dispatches

  resources :ways

  resources :assignations

  resources :containers

  resources :navies

  get 'welcome/index'
  get 'welcome/admin'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
