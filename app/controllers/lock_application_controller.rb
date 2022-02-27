# frozen_string_literal: true

module LockApplicationController
  module ClassMethods
    def lock(opts = {})
      before_filter { |c| c.lock_filter opts[:actions] }
    end
  end

  module InstanceMethods
    def lock_filter(actions = nil)
      redirect_to unlock_refused_url if locked_action?(actions) && (session[:lock_opened] != true)
      # otherwise proceed to where ya going
    end

    def locked_action?(actions)
      return false if controller_name == "lock"

      actions.blank? or actions.include?(controller_name.to_s) or actions.include?("#{controller_name}##{action_name}")
    end
  end
end
