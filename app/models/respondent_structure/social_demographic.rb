class SocialDemographic
  include MongoMapper::EmbeddedDocument

  key :parameters, Hash
  
end