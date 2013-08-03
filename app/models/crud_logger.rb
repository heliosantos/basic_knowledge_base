class CrudLogger
  include Mongoid::Document

  field :permalink, type: String
  field :updated, type: Boolean
  field :deleted, type: Boolean
  field :_id, type: String, default: ->{ permalink }

  validates_presence_of :permalink
end
