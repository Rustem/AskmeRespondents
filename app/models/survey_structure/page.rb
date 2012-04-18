class Page
  include MongoMapper::EmbeddedDocument
  
  key :title, String
  key :description, String
  key :page_number, Integer

  embedded_in :survey
  many :questions

  attr_accessible :title, :description, :page_number

  def self.get_survey_page(survey_id, page_id)
  	survey = Survey.find(survey_id)
  	survey.pages.detect {|page| page._id.to_s == page_id.to_s}
  end

  def self.get_page_number(survey_id, page_id)
    survey = Survey.find(survey_id)
    survey.pages.detect {|page| page._id.to_s == page_id.to_s }.page_number
  end
end
