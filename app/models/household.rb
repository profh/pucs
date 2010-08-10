class Household < ActiveRecord::Base
  #attr_accessible  :street, :city, :state, :zip, :home_phone, :free_lunch, :status, :active, :guardians_attributes, :students_attributes
  before_save :reformat_phone
  
  # Relationships
  has_many :guardians, :dependent => :destroy
  has_many :users, :through => :guardians
  has_many :students, :dependent => :destroy
  has_one :privacy_setting, :dependent => :destroy
  has_attached_file :photo
  
  #allow guardians and students to be nested within households
  accepts_nested_attributes_for :guardians, :reject_if => lambda { |guardian| guardian[:last_name].blank? || guardian[:first_name].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :students, :reject_if => lambda { |student| student[:first_name].blank? }, :allow_destroy => true
  
  # Validations
  validates_presence_of :street, :city, :state, :zip, :status
  validates_numericality_of :zip, :only_integer => true
  validates_format_of :home_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :message => "should be 10 digits", :allow_blank => true
  validates_format_of :zip, :with => /^\d{5}$/, :message => "should be 5 digits"
  validates_inclusion_of :status, :in => [1,2], :allow_blank => true
  validates_inclusion_of :state, :in => STATES_LIST.map {|key, value| value}, :message => "is not an option", :allow_nil => true, :allow_blank => true
  # validates_inclusion_of :state, :in => %w[PA OH WV]
  validates_format_of :city, :with => /^[a-z. -]+$/i
  
  # Paperclip Validations
  validates_attachment_size :photo, :less_than => 3.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg']
    
  #Named Scopes
  named_scope :all, :order => "street, city, state, zip"
  named_scope :by_guardians, :joins => :guardians, :conditions => ['is_primary = ?', true], :order => "last_name, first_name"
  named_scope :active, :conditions => ['households.active = ?', true]
  named_scope :free_lunch, :conditions => ['free_lunch = ?', true]
  named_scope :single_parent, :conditions => ['status = ?', 1]
  named_scope :two_parent, :conditions => ['status = ?', 2]
  named_scope :is_public, :joins => :privacy_setting, :conditions => ['public_names = ?', true]
  
  
  
  # Other Methods
  
  def address
    "#{self.street}, #{self.city}, #{self.state}, #{self.zip}"
  end
  
  def name
    parents = self.guardians.by_primary
    return "#{parents.first.name}" if parents.size==1
    if parents.first.last_name==parents.last.last_name
      "#{parents.first.last_name}, #{parents.first.first_name} & #{parents.last.first_name}"
    else
      "#{parents.first.name} & #{parents.last.name}"
    end
  end
  
  def type_of
    types = HOUSEHOLD_STATUS_LIST.map{|hs| hs[0]}
    types[self.status-1]
  end
  
  def lunch
    return "N/A" if self.free_lunch.nil?
    return "Free/Discounted Lunch" if self.free_lunch
    "N/A"  # blank may be optional
  end
  
  def make_inactive
    update_attribute(:active, false)
  end
  
  # Callback code
  # -----------------------------
   protected
     # We need to strip non-digits before saving to db
     def reformat_phone
       phone = self.home_phone.to_s
       phone.gsub!(/[^0-9]/,"") 
       self.home_phone = phone
     end
  
end
