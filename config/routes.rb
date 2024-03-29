Monociclo::Application.routes.draw do
  constraints(host: '1808.com.mx') do
    root to: redirect('http://www.1808.com.mx')
    match '/*path', to: redirect { |params| "http://www.example.com/#{params[:path]}" }
  end

  Mercury::Engine.routes

match "contacto" => "static_pages#contacto", :as => :contacto
match "quienes-somos" => "static_pages#quienes_somos", :as => :about
match "prensa" => "static_pages#prensa", :as => :prensa

resources :contacts
resources :photos
resources :albums do
  resources :photos, controller: 'AlbumPhotos', only: [:index, :create]
end
resources :album_photos, only: [:update, :destroy]

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'static_pages#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
