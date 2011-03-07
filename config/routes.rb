Rails.application.routes.draw do
  match "lock/login", :to=>"lock#login", :as=>"lock_login", :via=>:get
  match "lock/refused", :to=>"lock#refused", :as=>"unlock_refused", :via=>:get  
  match "lock/unlock", :to=>"lock#unlock", :as=>"unlock", :via=>:post
end