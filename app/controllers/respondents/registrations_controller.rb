class Respondents::RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    "/users/#{current_user.id.to_s}/edit"
  end
end	