ActionController::Routing::Routes.draw do |map|
  map.resources :infos
  map.root :controller=>'index'
  map.resources :news
  map.resources :users
  map.resource :session
  map.resources :hairstyles
  map.resources :areas,:collection => { :json => :get,:switch => :post,:convert_code_name => :post }
  map.resources :salons,:member => { :vote => :post,:map => :get },:collection => { :search => :get },:has_many=>[ :comments,:fwus,:flacks,:jobs,:businesses ]
  map.resources :sayings

  map.namespace :admin do |admin|
    admin.root :controller => 'index'
    admin.resources :meta_contents
    admin.resources :areas
    admin.resources :news
    admin.resources :hairstyles
    admin.resources :users
    admin.resources :salons,:has_many =>[ :comments ]
    admin.resources :sayings
  end

  map.namespace :user do |user|
    user.root :controller => 'index'
    user.resources :infos
    user.resources :salons,:has_many =>[ :fwus,:flacks,:jobs,:businesses ]
  end

  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'

  map.admin_top '/admin/top', :controller => 'admin/top', :action => 'index'
  map.admin_menu_tree '/admin/menu_tree', :controller => 'admin/menu_tree', :action => 'index'
  map.admin_main '/admin/main', :controller => 'admin/main', :action => 'index'

  map.flacks '/flacks', :controller => 'flacks', :action => 'flacks'
  map.jobs '/jobs', :controller => 'jobs', :action => 'jobs'
  map.businesses '/businesses', :controller => 'businesses', :action => 'businesses'
  map.user_profile '/user/profile', :controller => 'users', :action => 'edit'
  map.user_show '/user/name/:name', :controller => 'users', :action => 'show'
  map.about '/about',:controller=>'about'
#  map.connect ':controller/:action/:id.:format'
#  map.connect ':controller/:action/:id'
end