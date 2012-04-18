class Question
  include MongoMapper::Document
  
  connection(Mongo::Connection.new('localhost', 27017))
  set_database_name "surveys-#{Rails.env}"
  
  key :title, String
  key :question_number, Integer

  key :answer_object, Hash

  # generic settings
  key :help_text, String
  
  
  belongs_to :page
  
  one :question_type, :polymorphic => true 
  #one :question_setting

end
