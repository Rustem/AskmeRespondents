class Respond
  include MongoMapper::Document
  connection(Mongo::Connection.new('localhost', 27017))
  set_database_name "respond-#{Rails.env}"

  devise :trackable

  key :user, ObjectId
  key :date, Date
  key :ipaddress, String
  
  #trackable
  key :last_sign_in_at, Time
  key :last_sign_in_ip, String

  many :answers

  attr_accessible :user, :date, :ipaddress


end
