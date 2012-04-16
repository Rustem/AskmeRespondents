class ApplicationController < ActionController::Base
  protect_from_forgery

  	def log *args
		logger.debug "lol: "+args.map(&:to_s).join(' ')
	end
end
