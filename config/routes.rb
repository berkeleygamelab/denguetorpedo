Dengue::Application.routes.draw do
  
  resources :feedbacks

  # resources :contacts

  resources :notices


  match "/home/:id" => "home#index", :as => "Home"
  match "/faq" => 'home#faq'
  match "/manual" => "home#manual"
  match "/howto" => "home#howto"
  match '/contact' => 'home#contact'
  match 'about' => 'home#about'
  match '/education' => 'home#education'
  match '/credit' => 'home#credit'

  match "/user/:id/prize_codes" => 'prize_codes#index'
  match "/user/:id/prize_codes/:prize_id" => 'prize_codes#show'
  match "/user/:id/prize_codes/:prize_id/redeem/:prize_code_id" => 'prize_codes#redeem'
  post 'premios/:id' => "prizes#new_prize_code"
  match "/user/:id/buy_prize/:prize_id" => 'users#buy_prize'
  get "dashboard/index"
  get "password_resets/new"
  post "reports/sms"
  
  get "torpedos/:id" => "reports#torpedos"
  # SMS Gateway Routes
  get "/sb/rest/sms/inject" => "sms_gateway#inject"
  get "/sb/rest/sms/notifications" => "sms_gateway#notifications"
  get "/sb/rest/sms/remove" => "sms_gateway#remove"
  
  get '/cupons/sponsor/:id' => "prize_codes#sponsor"

  get '/phones' => "users#phones"

  get '/premios/admin' => "prizes#admin"
  # Resources Routes
  resources :users do
    resources :reports, :except => [:show]
    resources :posts
    collection do
      get 'special_new'
      post 'special_create'
      put 'block'
    end
  end
  
  resources :sponsors
  
  resources :dashboard
  resources :reports do
    collection do
      put 'update'
      post 'verify'
      post 'problem'
      post 'gateway'
    end
  #put 'reports' => 'reports#update'
  end
  
  resources :houses do
    resources :posts
  end
  
  resources :badges
  resource :session, :only => [:new, :create, :destroy]
  match 'exit' => 'sessions#destroy', :as => :logout
  resources :password_resets, :only => [:new, :create, :edit, :update]
  resources :verifications
  resources :forums, :only => [:index]
  resources :neighborhoods, :only => [:show]
  resources :buy_ins, :only => [:new, :create, :destroy]
  resources :group_buy_ins, :only => [:new, :create, :destroy]
  resources :prizes, :path => "premios"
  resources :prize_codes, :only => [:new, :create, :destroy, :show, :index], :path => "coupons"


  root :to => 'home#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
