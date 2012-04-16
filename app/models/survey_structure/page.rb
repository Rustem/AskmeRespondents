class Page
  include MongoMapper::EmbeddedDocument

  key :title, String
  key :description, String
  key :page_number, Integer

  many :questions
end
