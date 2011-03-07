require "lock"
require "rails"

module Lock
  class Engine < Rails::Engine
    initializer "lock.extend_application_controller" do
      ActiveSupport.on_load(:action_controller) do
        include LockApplicationController::InstanceMethods
        extend LockApplicationController::ClassMethods
      end
    end
  end
end