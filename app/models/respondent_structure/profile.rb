class Profile
  include MongoMapper::Document
  
  belongs_to :respondent

  one :social_demographic
  one :business
  one :map_of_wishes

end
