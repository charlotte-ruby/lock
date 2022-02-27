class LockController < ApplicationController
  def unlock
    if Lock.passwords_match?(params[:password])
      session[:lock_opened] = true
    else
      redirect_to :action=>:login
    end
  end
end