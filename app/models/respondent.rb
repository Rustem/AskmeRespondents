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
    where :slug => slug
  }

  def slug
    a = self.email.split('@')
    a[0]
  end

  def to_param
    "#{slug}"
  end
end
