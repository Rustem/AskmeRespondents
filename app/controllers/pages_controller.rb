class PagesController < ApplicationController
	def new
		@survey = Survey.find(params[:survey_id])
		@page = @survey.pages.build
	end


	def create
		@survey = Survey.find(params[:survey_id])
		@page = Page.new(params[:page])
		@page.page_number = @survey.pages.length+1
		@survey.pages.push(@page)	
		
		respond_to do |format|
			if @survey.save!
				format.html { redirect_to edit_survey_path(@survey, :pagenumber => @survey.pages.length ),  :notice => "Page was successfully added"}
        		format.json { head :no_content }
			else			
	 			format.html { render action: "new" }
        		format.json { render json: @survey.errors, status: :unprocessable_entity }
			end
		end
	end

	def edit 
		@survey = Survey.find(params[:survey_id])
		@page = Page.get_survey_page(params[:survey_id], params[:id])
	end

	def update
		@survey = Survey.find(params[:survey_id])
		@page = Page.get_survey_page(params[:survey_id], params[:id])
		@curPage = @page.page_number
		respond_to do |format|
	      if @page.update_attributes(params[:page])
	        format.html { redirect_to survey_edit_page_path(@survey, @curPage), :notice => "Settings were successfully saved" }
	        format.json { head :no_content }
	      else
	        format.html { render action: "edit" }
	        format.json { render json: @page.errors, status: :unprocessable_entity }
	      end
	    end
	end

	# refactored
	protected 
		
		def after_create_or_update(survey, curPage)
			
		end	

end
