class CrudLogger
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :permalink, type: String
  field :operation, type: String
  
  validates_inclusion_of :operation, allow_blank: false, in: ['created', 'updated', 'deleted'] 
  
  def self.log_operation(permalink, old_permalink, operation)
    log = CrudLogger.find_or_initialize_by(permalink: permalink)
    
    # the former permalink is to be deleted
    if permalink != old_permalink
      deletation_log = CrudLogger.find_or_initialize_by(permalink: old_permalink)
      deletation_log.operation = 'deleted'
      deletation_log.save
    end
    
    log.operation = operation
    log.save
  end
end
