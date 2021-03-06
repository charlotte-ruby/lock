module LockApplicationController
  module ClassMethods
    def lock(opts={})
      before_filter { |c| c.lock_filter opts[:actions] }
    end
  end
  
  module InstanceMethods
    def lock_filter(actions=nil)
      if locked_action?(actions) and session[:lock_opened]!=true
        redirect_to unlock_refused_url
      end
      #otherwise proceed to where ya going
    end
    
    def locked_action?(actions)
      return false if controller_name=="lock"
      actions.blank? or actions.include?("#{controller_name}") or actions.include?("#{controller_name}##{action_name}")
    end
  end
end