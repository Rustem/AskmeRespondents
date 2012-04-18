# build_resource - builds a class of model which mapped to devise object
class Respondents::SessionsController < Devise::SessionsController
  def new
    	super
  end

  protected
	  def after_sign_in_path_for(resource)
	    "/profile"
	  end
end	
