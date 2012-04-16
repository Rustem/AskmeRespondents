class Respondents::RegistrationsController < Devise::RegistrationsController
  after_filter :create_default_profile, :only => [:create]

  def create_default_profile
  	# default profile empty
  	profile = Profile.new
  	current_respondent.profile = profile
  end  	

   protected
	  def after_sign_up_path_for(resource)
	    "/respondents/#{current_respondent.id}/edit"
	  end
end	