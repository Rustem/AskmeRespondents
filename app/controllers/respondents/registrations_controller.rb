class Respondents::RegistrationsController < Devise::RegistrationsController
  after_filter :create_slug, :only => [:create, :update]
  after_filter :create_default_profile, :only => [:create]

  def create_default_profile
  	# default profile empty
    sd = SocialDemographic.new(:parameters=> {})
    b = Business.new(:parameters => {})
    mofwishes = MapOfWishes.new(:parameters => {})
  	profile = Profile.new()
    profile.social_demographic = sd
    profile.business = b
    profile.map_of_wishes = mofwishes

    current_respondent.profile = profile if current_respondent
  end  	

  def create_slug
    if current_respondent && current_respondent.set(:slug => current_respondent.generate_slug)
      current_respondent.reload
    else 
      raise p 'Registration_Controller exception while updating slug'
    end
  end  	

   protected
	  def after_sign_up_path_for(resource)
	    pr_edit_path
	  end
end	