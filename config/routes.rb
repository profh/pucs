ActionController::Routing::Routes.draw do |map|

  # generated routes for each model
  map.resources :households
  map.resources :guardians
  map.resources :students
  map.resources :announcements
  map.resources :events
  map.resources :signups
  map.resources :administrators
  map.resources :privacy_settings
  
  # routes for authentication
  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.resources :user_sessions
  map.resources :users
  
  # routes for password reset & forgot password
  map.change_password 'change_password', :controller => 'password_resets', :action => 'edit'
  map.new_password 'new_password', :controller => 'password_resets', :action => 'update'
  map.forgot_password 'forgot_password', :controller => 'password_resets', :action => 'new'
  map.reset_password 'reset_password', :controller => 'password_resets', :action => 'create'
  
  # for home page and other semi-static pagesx
  map.root :controller => 'user_sessions', :action => 'new'
  map.home ':page', :controller => 'home', :action => 'show', :page => /home|about|contact|privacy|volunteer|forms|eventsactivities|volunteeradmin|formsadmin|eventsactivitiesadmin/

  # default rails routes
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
