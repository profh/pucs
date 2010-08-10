class Event < ActiveRecord::Base
  attr_accessible :starting_at, :ending_at, :num_volunteers_needed, :event_name, :location, :active
  
  #Relationships
  has_many :signups
  has_many :guardians, :through => :signup
  
  #Validations
  validates_presence_of :starting_at, :ending_at, :event_name
  # validates_format_of :starting_at, :with => /(?n:^(?=\d)((?<month>(0?[13578])|1[02]|(0?[469]|11)(?!.31)|0?2(?(.29)(?=.29.((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|(16|[2468][048]|[3579][26])00))|(?!.3[01])))(?<sep>[-./])(?<day>0?[1-9]|[12]\d|3[01])\k<sep>(?<year>(1[6-9]|[2-9]\d)\d{2})(?(?=\x20\d)\x20|$))?(?<time>((0?[1-9]|1[012])(:[0-5]\d){0,2}(?i:\x20[AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$)/, :message => "should be mm/dd/yyyy hh:MM:ss AM/PM"
  # validates_format_of :ending_at, :with => /(?n:^(?=\d)((?<month>(0?[13578])|1[02]|(0?[469]|11)(?!.31)|0?2(?(.29)(?=.29.((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|(16|[2468][048]|[3579][26])00))|(?!.3[01])))(?<sep>[-./])(?<day>0?[1-9]|[12]\d|3[01])\k<sep>(?<year>(1[6-9]|[2-9]\d)\d{2})(?(?=\x20\d)\x20|$))?(?<time>((0?[1-9]|1[012])(:[0-5]\d){0,2}(?i:\x20[AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$)/, :message => "should be mm/dd/yyyy hh:MM:ss AM/PM"
  #   
  #Named Scopes
  named_scope :all, :order => "starting_at, ending_at"
  named_scope :active, :conditions => ['active = ?', true]
  
  #Other Methods
  
end
