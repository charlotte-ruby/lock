<<<<<<< HEAD
# frozen_string_literal: true

=======
>>>>>>> master
class LockController < ApplicationController
  def unlock
    if Lock.passwords_match?(params[:password])
      session[:lock_opened] = true
    else
<<<<<<< HEAD
      redirect_to action: :login
    end
  end
end
=======
      redirect_to :action=>:login
    end
  end
end
>>>>>>> master
