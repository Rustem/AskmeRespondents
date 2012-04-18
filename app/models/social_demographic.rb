class SocialDemographic
  include MongoMapper::EmbeddedDocument

  # ATTENTION!!!
  # may be create for each parameter seperate key???

  # parameters {age, race}
  key :parameters, Hash
  
end