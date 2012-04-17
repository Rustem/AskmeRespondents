class Business
  include MongoMapper::EmbeddedDocument

  key :parameters, Hash
end
