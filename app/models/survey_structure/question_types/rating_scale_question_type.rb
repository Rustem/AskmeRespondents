class RatingScaleQuestionType < QuestionType

 def self.generate_answer_object(textAreaValue1, textAreaValue2)
	answer_object, rows, cols = {}, {}, {} 
	rows = self.get_hash_from_value(textAreaValue1)
	cols = self.get_hash_from_value(textAreaValue2)
	answer_object["rows"] = rows
	answer_object["cols"] = cols
	p answer_object
  end

end	