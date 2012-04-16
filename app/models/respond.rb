class Respondent
  include MongoMapper::Document

  key :user, ObjectId
  key :date, Date
  key :ipaddress, String
  
  many :answers

  attr_accessible :user, :date, :ipaddress

end
