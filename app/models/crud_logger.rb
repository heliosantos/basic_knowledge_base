class CrudLogger
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :permalink, type: String
  field :operation, type: String
  field :article_id, type: Moped::BSON::ObjectId
  
  validates_inclusion_of :operation, allow_blank: false, in: ['created', 'updated', 'deleted'] 
  
  def self.log_operation(article_id, permalink, operation)
    log = CrudLogger.find_or_initialize_by(article_id: article_id)
    
    # the former permalink is to be deleted
    if not log.permalink.nil? and log.permalink != permalink
      CrudLogger.new(permalink: log.permalink, operation: 'deleted').save
    end
    
    log.permalink = permalink 
    log.operation = operation
    log.save
  end
end
