ActionController::Routing::Routes.draw do |map|
  map.resources :commands, :only => [ :create ]
  map.root :controller => 'shell', :action => 'index'
end
