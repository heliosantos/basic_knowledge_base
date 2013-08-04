class CrudLogger
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :permalink, type: String
  field :operation, type: String
  
  validates_inclusion_of :operation, allow_blank: false, in: ['created', 'updated', 'deleted'] 
  
  def self.log_operation(permalink, operation)
    log = CrudLogger.find_or_initialize_by(permalink: permalink)
    log.operation = operation
    log.save
  end
end
