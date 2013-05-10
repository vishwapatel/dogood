class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_cache_buster

  #This method is for overriding devise's routing once the
  #user has signed in successfully
  def after_sign_in_path_for(resource)
   user_path(current_user)
  end

  #Prevents the browser from caching pages so if the user
  #presses the back button then the page refreshes
  def set_cache_buster
	    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
	    response.headers["Pragma"] = "no-cache"
	    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
