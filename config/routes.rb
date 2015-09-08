Rails.application.routes.draw do
  resources :notification_histories

  get 'test_code/index'

  resources :user_histories

  post 'application/resetNotification'

  get 'assign/index'

  post 'assign/assignUser'

  post 'assign/unAssignUser'

  get 'assign/searchNotAssigned'

  get 'assign/searchAssigned'

  get 'invalid_entry/index'

  get 'allocated_tasks/index'

  delete 'allocated_tasks/deleteOpportunity'

  get 'statistics/index'

  get 'crm/index'

  post 'crm/calculateChanges'

  post 'crm/updateCRM'

  get 'crm/download'

  put 'tasks/updateStatus'

  delete 'tasks/deleteOpportunity'

  get 'history/index'

  get 'browse/index'

  get 'browse/getAllOppties'

  get 'tasks/index'

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  post 'users/new'

  get 'users/create'

  resources :histories

  resources :user_oppties, :only =>[:create]

  resources :oppties, :only=>[:edit, :show, :update]

  resources :users, :only => [:new, :create] 

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'sessions#new', as: 'new'

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
