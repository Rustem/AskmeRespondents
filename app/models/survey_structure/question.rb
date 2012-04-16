class Question
  include MongoMapper::Document

  key :title, String
  key :question_number, Integer

  key :answer_object, Hash

  # generic settings
  key :help_text, String
  
  belongs_to :page
  one :question_type, :question_settings
end
