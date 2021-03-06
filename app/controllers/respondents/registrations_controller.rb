class Respondents::RegistrationsController < Devise::RegistrationsController
  after_filter :create_slug, :only => [:create, :update]
  after_filter :create_default_profile, :only => [:create]

  # create resource with session
  def new 
    super
  end

  def create_default_profile
  	# default profile empty
    current_respondent.profile = self.class.populate_default_user_profile if current_respondent
  end  	

  def create_slug
    if current_respondent && current_respondent.set(:slug => current_respondent.generate_slug)
      current_respondent.reload
    else 
      set_flash_message :notice, :signed_up_but_cannot_update_slug
    end
  end  	

  def self.populate_default_user_profile
    profile = Profile.new()
    profile.social_demographic = SocialDemographic.new(:parameters=> {})
    profile.business = Business.new(:parameters => {})
    profile.map_of_wishes = MapOfWishes.new(:parameters => {})
    profile
  end

   protected
	  def after_sign_up_path_for(resource)
	    pr_edit_path
	  end
end	