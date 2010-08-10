class Signup < ActiveRecord::Base
  
  attr_accessible :guardian_id, :event_id, :attended, :active

  #Relationships
  belongs_to :guardian
  belongs_to :event
  
  #Validations
  validates_presence_of :guardian_id, :event_id
  validates_numericality_of :guardian_id, :only_integer => true
  validates_numericality_of :event_id, :only_integer => true
  
  #Named Scopes
  named_scope :all, :order => "guardian_id, event_id"
  named_scope :active, :conditions => ['active = ?', true]
  
  #Other Methods

end
