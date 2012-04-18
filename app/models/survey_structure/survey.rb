class Survey
  include MongoMapper::Document

  connection(Mongo::Connection.new('localhost', 27017))
  set_database_name "surveys-#{Rails.env}"
  
  key :title, String
  key :description, String
  key :active, Boolean
  key :expires, Date

  many :pages
  
end
