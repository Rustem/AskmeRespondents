class Respondent
  include MongoMapper::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable


  key :username, String
  key :email, String
  key :encrypted_password, String
  key :firstname, String
  key :lastname, String
  key :city, String
  key :phone_number, String

  key :slug, String

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

  attr_accessible :username, :email, :password, :password_confirmation, :created_at, :updated_at, :slug

  validates_presence_of  :email
  validates_uniqueness_of :email

  scope :by_slug,  lambda { |slug| 
    where(:slug => slug).first
  }

  def convert_to_slug(emailPrefix)
     if defined?(ActiveSupport::Inflector.parameterize)
       ActiveSupport::Inflector.parameterize(emailPrefix).to_s
     end       
     emailPrefix.downcase.gsub!(/[\W]/, '_') {|match| emailPrefix = match}
  end    

  def generate_slug
    return if self.email.blank?
    tail, int = "", 1
    a = self.email.split('@')
    initial = convert_to_slug(a[0])
    
    objectResp = Respondent.find_by_slug(initial + tail)
    p objectResp.inspect
     if !objectResp.nil?
       objectResp.each do 
         int  += 1
         tail = "-#{int}"
       end
     end
    return initial + tail
  end



  def to_param
    "#{slug}"
  end
end
