SvezeJabolko::Application.routes.draw do
  
  root :to => "articles#index"

  match "admin", :controller => "admin", :action => "dash", :as => "admin", :via => [:get]
  devise_for :users, :controllers => { :sessions => "admin/sessions" }
  
  
  namespace "admin" do
    resources :categories, :users, :banners
    resources :articles do
      get :publish, :on => :member, :via => [:get]
      post :publish, :on => :member, :to => "articles#publish_article"
      put :publish, :on => :member, :to => "articles#publish_article"
      get :preview, :on => :collection, :to => "articles#preview"
    end
    
    resources :tags do
      get :search, :on => :collection, :via => [:get]
    end
    
  end
  
  match "feed" => "articles#feed"

  match "avtorji/:user_id" => "authors#show", :as => :author
  match "avtorji" => "authors#index", :as => :authors
  match "404" => "application#missing_page", :as => :missing_page

  match "tag/:tag_id" => "tags#show", :as => :tag
  match "znacke" => "tags#index", :as => :tags
  # match "tags" => "tags#index", :as => :tags
  
  match "v/:id" => "banners#visit", :as => :banner_visit
  
  match "blog/:id" => "articles#show", :as => :blog
  match ":category_id/:id" => "articles#show", :as => :article
  match ":category_id" => "categories#show", :as => :category
  
=begin  
  match "admin", :controller => "admin/articles", :action => "index", :as => "admin", :via => [:get]
   devise_for :users, :path => "admin"
   
=end   
  #resources :categories, :only => [:show, :index], :via => [:get] do
  #  resources :articles, :only => [:show, :index], :via => [:get]
  #end
  
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
