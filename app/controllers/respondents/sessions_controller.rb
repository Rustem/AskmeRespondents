# build_resource - builds a class of model which mapped to devise object
class Respondents::SessionsController < Devise::SessionsController
	def new
		super
	end
end