class Answer
	include MongoMapper::EmbeddedDocument

	key :question_id, ObjectId
	key :value, String

	attr_accessible :question_id, :value
end