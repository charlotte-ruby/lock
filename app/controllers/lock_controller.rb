class LockController < ApplicationController
  def login
  end
  
  def unlock
    password = params[:password]
    if Lock.passwords_match?(password)
      session[:lock_opened] = true
    else
      redirect_to :action=>:login
    end
  end
  
  def refused
  end
end