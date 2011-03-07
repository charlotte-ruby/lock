require "lock"
require "rails"

module Lock
  class Engine < Rails::Engine
      #rake_tasks do
        #load "lock/railties/tasks.rake"
      #end
      
      #initializer 'lock.helper' do |app|
        #ActionView::Base.send :include, LockHelper
      #end
  end
end