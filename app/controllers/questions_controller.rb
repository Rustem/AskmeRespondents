class QuestionsController < ApplicationController

	def index

	end

	def new
		@survey = Survey.find(params[:survey_id])
		@page = Page.get_survey_page(@survey.id, params[:page_id])	
		@question = Question.new	
		code = params[:code]
		# what kind of view to load next depends on question type
		case code
			when 'mc'
				@render_question_type = 'new_multiple_choice_form'
			when 'es'
				@question.question_type = EssayQuestionType.new
			else 
				raise p 'fakdsfj;lasdj;lfja;sjdf;lajsd'
		end			
	end

	def create
		@survey = Survey.find(params[:survey_id])
		
		@page = Page.get_survey_page(@survey.id, params[:page_id])	

		@curpage = Page.get_page_number( @survey.id, @page.id )

		@question = Question.new(params[:question])
		
		# create instance object of appopriate question type
		@question.question_type = generate_question_type
		# create answer object
		@question.answer_object = @question.question_type.class.generate_answer_object(params[:question][:answer_object])

		@page.questions << @question

		respond_to do |format|
			if @question.save
				format.html { redirect_to edit_survey_path(@survey, :pagenumber => @curpage ),  :notice => "Question was successfully added"}
        		format.json { head :no_content }
			else			
	 			format.html { render action: "new" }
        		format.json { render json: @question.errors, status: :unprocessable_entity }
			end
		end

	end

	def edit

	end

	def update
	
	end		

	protected
		def generate_question_type
			question_type = nil
			case @question.code
				when 'mc'
					question_type = MultipleChoiceQuestionType.new
				when 'es'
					question_type = EssayQuestionType.new
				else
					raise "There is no such type"
			end
			question_type
		end			
		
end
