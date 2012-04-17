class QuestionType
  include MongoMapper::EmbeddedDocument

  key :type, String
  key :code, String

end
