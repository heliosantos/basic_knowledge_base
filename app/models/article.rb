class Article
  include Mongoid::Document
  include Mongoid::Search

  field :title, type: String
  field :body, type: String

  before_create :set_slug_as_id

  private 
  def set_slug_as_id
    self.id = self.title.to_slug
  end

  search_in :title, :body

end