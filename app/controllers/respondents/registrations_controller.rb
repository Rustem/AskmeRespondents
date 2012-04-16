class Respondents::RegistrationsController < Devise::RegistrationsController
  after_filter :create_slug, :only => [:create, :update]
  after_filter :create_default_profile, :only => [:create]

  def create_default_profile
  	# default profile empty
     profile = Profile.new()
     profile.social_demographic = SocialDemographic.new(:parameters=> {})
     profile.business = Business.new(:parameters => {})
     profile.map_of_wishes = MapOfWishes.new(:parameters => {})
    
    current_respondent.profile = profile if current_respondent
  end  	

  def create_slug
    p current_respondent
    if current_respondent && current_respondent.set(:slug => current_respondent.generate_slug)
      current_respondent.reload
    else 
      set_flash_message :notice, :"Sorry, can't update your settings, you are not allowed to register!" 
    end
  end  	

   protected
	  def after_sign_up_path_for(resource)
	    pr_edit_path
	  end

    def populate_default_user_profile
      profile = Profile.new()
      profile.social_demographic = SocialDemographic.new(:parameters=> {})
      profile.business = Business.new(:parameters => {})
      profile.map_of_wishes = MapOfWishes.new(:parameters => {})
    end
end	