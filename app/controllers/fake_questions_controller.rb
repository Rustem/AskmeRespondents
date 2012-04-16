class FakeQuestionsController < ApplicationController
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

	def submitAnswers
		respond = Respond.new()
		params.each do |key, value|
		end
		if @user.save!
			redirect_to root_url
		else			
			render :action => :new
		end
	end
end
