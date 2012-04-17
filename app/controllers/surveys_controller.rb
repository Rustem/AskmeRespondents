class SurveysController < ApplicationController
	def index
		@surveyTitle = "Test Survey"
		@questionList = [
			{:id => 1, :title => "Question1", :answers => ["answer1", "answer2"] },
			{:id => 2, :title => "Question2", :answers => ["answer1", "answer2"] },
			{:id => 3, :title => "Question3", :answers => ["answer1", "answer2"] },
			{:id => 4, :title => "Question4", :answers => ["answer1", "answer2"] }
		]
		@noheader = true
	end

	def new
		@survey = Survey.new
	end

	def create
		@survey = Survey.new(params[:survey])
		if @survey.save!
		 	redirect_to edit_survey_path(@survey), :notice => "Settings were successfully saved"
		else			
		 	render :action => :index
		end
	end

	def edit
		@survey = Survey.find(params[:id])
	end

	def update
		@survey = Survey.find(params[:id])
		respond_to do |format|
	      if @survey.update_attributes(params[:survey])
	        format.html { redirect_to edit_survey_path(@survey), :notice => "Settings were successfully saved" }
	        format.json { head :no_content }
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @user.errors, status: :unprocessable_entity }
	      end
	    end
	end
end
