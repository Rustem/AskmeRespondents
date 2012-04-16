class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
  	@noheader = true
  end
end
