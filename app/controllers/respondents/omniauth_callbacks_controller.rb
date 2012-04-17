class Respondents::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    omniauth = request.env["omniauth.auth"]

    p omniauth

    email = omniauth.extra.raw_info.email

    r = Respondent.find(email: email)

    render :text => r
    return
  end

  def vkontakte
    # You need to implement the method below in your model
    omniauth = request.env["omniauth.auth"]

    session['oa'] = omniauth if session['oa'].nil?
    omniauth = session['oa']

    p omniauth

    render :text => omniauth.uid.to_s+' '+omniauth.extra.domain.to_s+' '+omniauth.provider.to_s
    return

    #@user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    <<-HD_COMMENT
#<OmniAuth::AuthHash credentials=#<Hashie::Mash expires=true expires_at=1334548991 
token="14e258fb14928098149280985214becb1f114921493808a85a4db0752d9c5b6"> 
extra=#<Hashie::Mash raw_info=#<Hashie::Mash bdate="23.2.1991" 
city="183" country="4" domain="mzhomart" 
first_name="Zhomart" 
last_name="Mukhamejanov" nickname="" 
online=0 photo="http://cs5324.userapi.com/u7395427/e_3aeb4fcb.jpg" 
photo_big="http://cs5324.userapi.com/u7395427/a_70ce8d7c.jpg" 
sex=2 uid=7395427>> info=#<OmniAuth::AuthHash::InfoHash 
first_name="Zhomart" image="http://cs5324.userapi.com/u7395427/e_3aeb4fcb.jpg" 
last_name="Mukhamejanov"  name="Zhomart Mukhamejanov" 
nickname="" urls=#<Hashie::Mash Vkontakte="http://vk.com/mzhomart">> provider="vkontakte" uid=7395427>

    HD_COMMENT
    #if @user.persisted?
    #  flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
    #  sign_in_and_redirect @user, :event => :authentication
    #else
    #  session["devise.facebook_data"] = request.env["omniauth.auth"]
    #  redirect_to new_user_registration_url
    #end
  end
end	