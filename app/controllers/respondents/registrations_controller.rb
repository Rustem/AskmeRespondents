class Respondents::RegistrationsController < Devise::RegistrationsController
  after_filter :create_slug, :only => [:create, :edit]
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
  	current_respondent.profile = profile
  end  	

  def create_slug
    current_respondent.set(:slug=>current_respondent.slug)
    #current_respondent.reload
  end

   protected
	  def after_sign_up_path_for(resource)
	    "/respondents/#{current_respondent.id.to_s}/edit"
	  end
end	