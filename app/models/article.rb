class Article
  include Mongoid::Document

  field :title, type: String
  field :body, type: String

  before_create :set_slug_as_id

  private 
  def set_slug_as_id
    self.id = self.title.to_slug
  end
end
