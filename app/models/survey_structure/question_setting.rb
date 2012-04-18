class QuestionSetting
  include MongoMapper::EmbeddedDocument

  key :parameters, Hash, :default=>{:required=>false, :help_text=>'', :shuffled=>false }

end
