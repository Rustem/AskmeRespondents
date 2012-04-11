class MapOfWishes
  include MongoMapper::EmbeddedDocument

  key :parameters, Hash
end
