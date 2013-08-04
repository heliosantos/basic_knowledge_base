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
    log = CrudLogger.new(permalink: self.permalink, updated: true, deleted: false)
    log.save    
  end
  
  def update_attributes(attributes = [])
    super(attributes)
    log = CrudLogger.new(permalink: self.permalink, updated: true, deleted: false)
    log.save
  end
  
  def destroy
    log = CrudLogger.new(permalink: self.permalink, updated: false, deleted: true)
    log.save     
    super    
  end
  
  
  
  
  
  search_in :title, :body

end
