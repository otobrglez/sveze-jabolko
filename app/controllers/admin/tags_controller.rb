class Admin::TagsController < AdminController
  
  inherit_resources
  actions :all, :except => [:index]
  defaults :route_prefix => 'admin'
  
end