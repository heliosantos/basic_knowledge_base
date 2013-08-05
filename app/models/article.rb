class Article
  include Mongoid::Document
  include Mongoid::Search
  include Mongoid::Timestamps

  field :title, type: String
  field :body, type: String
  field :permalink, type: String

  validates_presence_of :title, :body

  
  def save    
    self.permalink = self.title.to_slug
    super
    CrudLogger.log_operation(self.permalink, self.permalink, 'created')
  end
  
  def update_attributes(attributes = [])
    a = Article.find(self.id)
    old_permalink = ''
    
    if !a.nil?
      old_permalink = a.permalink
    end
    
    super(attributes)
    CrudLogger.log_operation(self.permalink, old_permalink, 'updated')
  end
  
  def destroy
    super    
    CrudLogger.log_operation(self.permalink, self.permalink, 'deleted')
  end
  
  search_in :title, :body

end
