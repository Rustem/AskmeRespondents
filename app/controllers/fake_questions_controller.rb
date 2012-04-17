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
		#raise p params.inspect
		respond = Respond.new()
		respond.user = current_respondent.id unless current_respondent.nil?
		params.each do |key, value|
			if (key.to_s.starts_with? 'q_')
				answer = Answer.new()
				answer.question_id = key.to_s[2..key.to_s.length-1]
				answer.value = value
				respond.answers.push(answer) 
			end 
		end
		if respond.save!
		 	redirect_to root_url
		else			
		 	render :action => :index
		end
	end
end
