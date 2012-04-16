class Answer
	include MondoMapper::EmbeddedDocument

	key: question_id, ObjectId
	key: value, String
end