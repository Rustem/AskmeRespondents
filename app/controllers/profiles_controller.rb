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
		if profile.social_demographic.set(params[:social_demographic])
			format.html { redirect_to @respondent, notice: 'Your profile:social-demographic was successfully updated.' }
	        format.json { head :no_content }
	    else	
	    	format.html { render action: "edit" }
	        format.json { render json: @respondent.errors, status: :unprocessable_entity }
		end	
	end		
end
