class Respondent
  include MongoMapper::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :, :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable


  key :username, String
  key :email, String
  key :encrypted_password, String
  key :firstname, String
  key :lastname, String
  key :city, String
  key :phone_number, String

  key :slug, String

  # omniauthable fields
  key :omniauth, Array

  # trackable
  key :sign_in_count, Integer, :default => 0
  key :current_sign_in_at, Time
  key :last_sign_in_at, Time
  key :current_sign_in_ip, String
  key :last_sign_in_ip, String
  
  key :remember_created_at, Time
  key :reset_password_sent_at, Time
  
  #recoverable
  key :reset_password_token, String

  #associations
  one :profile, :dependent => :destroy

  attr_accessible :username, :email, :password, :password_confirmation, :created_at, :updated_at, :slug, :omniauth

  validates_presence_of  :email
  validates_uniqueness_of :email

  scope :by_slug,  lambda { |slug| 
    where(:slug => slug).first
  }

  scope :find_by_provider_and_uid, lambda { |provider, uid|
    where(omniauth: {provider: provider, uid: uid})
  }

  def include_omniauth(omniauth)
    self.omniauth.select{|o| o['provider']==omniauth.provider and o['uid']==omniauth.uid}.count == 1
  end


  def update_omniauth(omniauth)
    self.omniauth << {provider: omniauth.provider, uid: omniauth.uid} unless self.include_omniauth omniauth

    self.firstname = firstname.to_s.empty_or_self || omniauth.extra.raw_info.first_name || ''
    self.lastname = lastname.to_s.empty_or_self || omniauth.extra.raw_info.last_name || ''
    self.city = city.to_s.empty_or_self || omniauth.extra.raw_info.location.name || ''

    if Respondent.where(username: omniauth.extra.raw_info.username.downcase).count == 0
      self.username = username.to_s.empty_or_self || omniauth.extra.raw_info.username.downcase || ''
    end

    save!
  end

  <<-OMNIAUTH_AUTH_HASH
    {
      :provider => 'facebook',
      :uid => '1234567',
      :info => {
        :nickname => 'jbloggs',
        :email => 'joe@bloggs.com',
        :name => 'Joe Bloggs',
        :first_name => 'Joe',
        :last_name => 'Bloggs',
        :image => 'http://graph.facebook.com/1234567/picture?type=square',
        :urls => { :Facebook => 'http://www.facebook.com/jbloggs' },
        :location => 'Palo Alto, California',
        :verified => true
      },
      :credentials => {
        :token => 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
        :expires_at => 1321747205, # when the access token expires (if it expires)
        :expires => true # if you request `offline_access` this will be false
      },
      :extra => {
        :raw_info => {
          :id => '1234567',
          :name => 'Joe Bloggs',
          :first_name => 'Joe',
          :last_name => 'Bloggs',
          :link => 'http://www.facebook.com/jbloggs',
          :username => 'jbloggs',
          :location => { :id => '123456789', :name => 'Palo Alto, California' },
          :gender => 'male',
          :email => 'joe@bloggs.com',
          :timezone => -8,
          :locale => 'en_US',
          :verified => true,
          :updated_time => '2011-11-11T06:21:03+0000'
        }
      }
    }
  OMNIAUTH_AUTH_HASH

  def convert_to_slug(emailPrefix)
     if defined?(ActiveSupport::Inflector.parameterize)
       ActiveSupport::Inflector.parameterize(emailPrefix).to_s
     end       
     emailPrefix.downcase.gsub(/[\W]/, '_') {|match| emailPrefix = match}
  end

# correct objectResp is not Enumerable
  def generate_slug
    return if self.email.blank?
    tail, int = "", 1
    a = self.email.split('@')
    initial = convert_to_slug(a[0])
    p a, a[0], initial
    
    while Respondent.find_by_slug(initial + tail)
         int  += 1
         tail = "-#{int}"
    end
    return initial + tail
  end


  def to_param
    "#{slug}"
  end

end

class String
  def empty_or_self
    empty? || self.strip.length == 0 ? nil : self
  end
end
