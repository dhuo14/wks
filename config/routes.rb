Wks::Application.routes.draw do
  # get "departments/index"
  # get "departments/new"
  # get "departments/create"
  # get "departments/update"
  # get "departments/edit"
   #get "article_catalogs/new"
  # get "article_catalog/create"
  # get "article_catalog/edit"
  # get "article_catalog/delete"
  # get "article_catalog/update"
  # get "user/logout"
  # get "user/login"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   #root 'home#index'
  root :to => 'home#index'

  captcha_route

# 后台
  namespace :kobe do
    resources :departments, :except => ["show"]
  end

  resources :shared do
    collection do
      delete :department, :area
      get :department, :area
    end
  end

  resources :kobe, :only => ["index"] do
    collection do
      get :ui, :test
    end
  end

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
