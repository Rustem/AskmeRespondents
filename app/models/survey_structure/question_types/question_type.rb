class QuestionType
  include MongoMapper::EmbeddedDocument
  # all operations to be safe: if succedd ok , otherwise - raise an error

  key :type, String, :default => 'multiple choice'
  key :code, String, :default => 'mc'

  attr_accessible :code
  embedded_in :Question

  # this method should be overriden for each question type appropriately
  def self.generate_answer_object(textAreaValue)
		self.get_hash_from_value(textAreaValue)
  end



  protected 
  	def self.get_hash_from_value(textAreaValue)
	  	hash = {}
	  	textAreaValue.split(/\r\n/).each_with_index do |item, idx|
			hash["answer_" + idx.to_s] = item unless item == ''
		end
		hash
  end
end


