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
	# survey should has default page in instantiation process
	def new
		@survey = Survey.new
		respond_to do |format|
	        format.html {render html: new_survey_path}
      		format.json { render json: @survey }
	    end
	end
	
	def create
		@survey = Survey.new(params[:survey])
		@survey.pages << add_default_page
		
		respond_to do |format|
			if(@survey.save!)
				format.html { redirect_to edit_survey_path(@survey), :notice => "Settings were successfully saved" }
    		    format.json { head :no_content }
			else
				format.html { render action: "new" }
		        format.json { render json: @survey.errors, status: :unprocessable_entity }
			end					
		end
	end

	def edit
		@survey = Survey.find(params[:id])
		@curPage = params[:pagenumber] || 1
		
		if @curPage == 1 && !params[:pagenumber]
			@actTab = false
		else
			@actTab = true
		end
		respond_to do |format|
	        format.html # show.html.erb
      		format.json { render json: @survey }
	    end
	end

	def update
		@survey = Survey.find(params[:id])
		@curPage = params[:pagenumber] || 1
		respond_to do |format|
	      if @survey.update_attributes(params[:survey])
	        format.html { redirect_to survey_edit_page_path(@survey, @curPage), :notice => "Settings were successfully saved" }
	        format.json { head :no_content }
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @survey.errors, status: :unprocessable_entity }
	      end
	    end
	end

	private 
		def add_default_page()
			Page.new(:title=>'Default Page', :description=>'You can add new pages!', :page_number=>1)
 		end			
end
