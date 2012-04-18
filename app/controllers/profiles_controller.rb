class ProfilesController < ApplicationController

	def edit
		@profile = current_respondent.profile
	end

	def update
		# profile = current_respondent.profile
		# if params[:social_demographic]
		# 	if profile.social_demograchic.set(params[:social_demographic])
			
		# 	end				
		# elsif params[:business]
		# 	if profile.business.set(params[:business])

		# 	end
		# elsif params[:map_of_wishes]
		# 	if profile.map_of_wishes.set(params[:map_of_wishes])

		# 	end
		# end
		# profile.reload

	end

	def social_demographic_settings
		profile = current_respondent.profile
		@sd = profile.social_demographic
		@respondent = current_respondent
		profile.social_demographic.parameters = params[:social_demographic]
		profile.save
		redirect_to current_respondent
	end		

	def business_settings
		profile = current_respondent.profile
		@sd = profile.social_demographic
		@respondent = current_respondent
		
		profile.business.parameters = params[:business]
		profile.save
	    redirect_to current_respondent
	end		
end
