class Respondents::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    omniauth = request.env["omniauth.auth"]
    
    email = omniauth.info.email.to_s.downcase

    if r = Respondent.where(email: email).first
      # try to SIGN IN
      
      if r.include_omniauth omniauth
          # facebook CONNECTED
      else
          # facebook NOT CONNECTED
      end

      # update user profile
      r.update_omniauth omniauth

      sign_in(:respondent, r) and redirect_to pr_edit_path
    else
      # respondent should SIGN UP

      r = Respondent.create(email: email, password: SecureRandom.base64(12))
      r.profile = Respondents::RegistrationsController.populate_default_user_profile
      r.save!

      r.update_omniauth omniauth

      sign_in(:respondent, r) and redirect_to pr_edit_path
    end

    #render text: ''
  end

  def vkontakte
    # You need to implement the method below in your model
    omniauth = request.env["omniauth.auth"]

    provider = omniauth.provider.to_s
    uid = omniauth.uid.to_s

    r = Respondent.find_by_provider_and_uid(provider, uid)

    render :text => 'not implemented'
    #if @user.persisted?
    #  flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
    #  sign_in_and_redirect @user, :event => :authentication
    #else
    #  session["devise.facebook_data"] = request.env["omniauth.auth"]
    #  redirect_to new_user_registration_url
    #end
  end

      <<-HD_COMMENT
        :raw_info => {
          :id => '1234567',
          :name => 'Joe Bloggs',
          :first_name => 'Joe',
          :last_name => 'Bloggs',
          :link => "http://www.facebook.com/mzhomart",
          :username => 'jbloggs',
          :location => { :id => '123456789', :name => 'Palo Alto, California' },
          :gender => 'male',
          :email => 'joe@bloggs.com',
          :timezone => 6,
          :locale => 'en_US',
          :verified => true,
          :updated_time => '2011-11-11T06:21:03+0000',
          :birthday => "02/23/1991",
          :education => [#<Hashie::Mash school=#<Hashie::Mash id="110948398932579" name="RSPHMSH, fiz-mat"> type="High School" year=#<Hashie::Mash id="138383069535219" name="2005">>, ...],
          :languages => [#<Hashie::Mash id="109582215727860" name="Kazakh">, ...],
          :religion => "Muslim",
          :updated_time => "2012-04-17T06:58:03+0000"
        }
    HD_COMMENT
end 