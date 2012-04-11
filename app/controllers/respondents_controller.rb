class RespondentsController < ApplicationController
	before_filter :authenticate_respondent!, :except => [:index]
	def index
		@users = Respondent.all
	end		

	def new
		@user = Respondent.new
	end		

	def show
		@respondent ||= current_respondent

	end

	def create
		@user = Respondent.new(params[:user])
		profile = Profile.new()
		sd = SocialDemographic.new(:parameters=> {:age=>23, :gender=> 'm'})
		b = Business.new(:parameters => {:monthly_profit=>700, :employees_in_company=>300})
		mofwishes = MapOfWishes.new(:parameters => {:relax=>['a', 'b', 'c']})
		
		profile.social_demographic = sd
		profile.business = b
		profile.map_of_wishes = mofwishes
		@user.profile = profile
		if @user.save!
			redirect_to root_url
		else			
			render :action => :new
		end
	end		

	def edit
		@respondent = Respondent.find_by_id(params[:id])
	end

	# update profile
	def update
		@respondent = Respondent.find_by_id(params[:id])
		respond_to do |format|
	      if @respondent.update_attributes(params[:respondent])
	        format.html { redirect_to @respondent, notice: 'Your profile was successfully updated.' }
	        format.json { head :no_content }
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @respondent.errors, status: :unprocessable_entity }
	      end
	    end
	    @respondent.save
	end
end
