class Guardian < ActiveRecord::Base
  #attr_accessible :first_name, :last_name, :household_id, :is_primary, :relationship, :is_female, :ethnicity, :mobile_phone, :work_phone, :user_id, :security_form, :active, :user_attributes
  before_save :reformat_phones
  
  #Relationships
  belongs_to :household
  has_many :students, :through => :household
  belongs_to :user, :dependent => :destroy
  
  #allow user to be nested within guardian
  accepts_nested_attributes_for :user, :reject_if => lambda {|user| user[:username].blank? }, :allow_destroy => true
  
  
  #Validations
  validates_presence_of :first_name, :last_name
  validates_format_of :mobile_phone, :with => /^(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})$/  ,:message => "should be 10 digits", :allow_blank => true
  validates_format_of :work_phone, :with => /^(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})$/  ,:message => "should be 10 digits", :allow_blank => true
  validates_numericality_of :ethnicity, :only_integer => true, :greater_than => 0, :less_than => 7, :allow_blank => true
  validates_numericality_of :relationship, :only_integer => true, :greater_than => 0, :less_than => 8, :allow_blank => true
  # validates_format_of :email, :with => /^[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))$/i, :message => "is not a proper email", :allow_blank => true
   
   
  #Names Scope
   named_scope :all, :order => "last_name, first_name"
   named_scope :by_primary, :order => "is_primary DESC"
   named_scope :active, :conditions => ['guardians.active = ?', true]
   named_scope :primary, :conditions => ['is_primary = ?', true]
   named_scope :by_household, lambda { |household_id| { :conditions => ['household_id = ?', household_id] } }
   named_scope :by_relationship, lambda { |relationship| { :conditions => ['relationship = ?', relationship] } }
   named_scope :by_race, lambda { |ethnicity| { :conditions => ['ethnicity = ?', ethnicity] } }
      

  # Other Methods
  def name
    "#{self.last_name}, #{self.first_name}"
  end 
  
  def nice_name
  	"#{self.first_name} #{self.last_name}"
  end
 	
  def gender
    return "" if self.is_female.nil?
    return "Female" if self.is_female
    "Male"
  end
  
  def race
    return "" if self.ethnicity.nil?
    races = RACE_LIST.map{|r| r[0]}
    races[self.ethnicity-1]
  end
  
  def relation
    return "" if self.relationship.nil?
    relations = RELATIONSHIP_LIST.map{|r| r[0]}
    relations[self.relationship-1]
  end
  
  def partners
    Guardian.find(:all, :conditions => ['household_id = ? and id != ?', self.household_id, self.id])
  end
  
  def make_inactive
    update_attribute(:active, false)
  end
  
   
  # Callback code
  # -----------------------------
   protected
     # We need to strip non-digits before saving to db
     def reformat_phones
       # reformat mobile phone first...
       unless self.mobile_phone.nil?
         phone = self.mobile_phone.to_s
         phone.gsub!(/[^0-9]/,"")
         self.mobile_phone = phone
       end
       # now deal with work phone...
       unless self.work_phone.nil?
         phone2 = self.work_phone.to_s  
         phone2.gsub!(/[^0-9]/,"") 
         self.work_phone = phone2
       end
     end
end
