class MultipleChoiceQuestionType < QuestionType

 def self.generate_answer_object(textAreaValue)
	self.get_hash_from_value(textAreaValue)
 end
end	