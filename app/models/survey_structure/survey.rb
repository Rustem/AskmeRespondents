class Survey
  include MongoMapper::Document

  key :title, String
  key :description, String
  key :active, Boolean
  key :expires, Date

  many :pages
end
