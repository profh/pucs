
class Student < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :household_id, :grade, :dob, :ethnicity, :is_female, :engrade_id, :active

  # Relationships
  belongs_to :household
  has_many :guardians, :through => :household
  
  
  # Validations
  validates_presence_of :first_name, :last_name
  validates_numericality_of :grade, :only_integer => true, :greater_than_or_equal_to => 0, :less_than => 9
  validates_numericality_of :engrade_id, :only_integer => true, :greater_than => 0, :allow_blank => true
  validates_numericality_of :ethnicity, :only_integer => true, :greater_than => 0, :less_than => 7, :allow_blank => true
  validates_date :dob, :before => lambda { 4.years.ago }, :before_message => "must be at least 4 years old", :allow_blank => true


  # Named Scopes
  named_scope :all, :order => "last_name, first_name"
  named_scope :active, :conditions => ['students.active = ?', true]
  named_scope :by_household, lambda { |household_id| { :conditions => ['household_id = ?', household_id] } }
  named_scope :girls, :conditions => ['is_female = ?', true]
  named_scope :boys, :conditions => ['is_female = ?', false]
  named_scope :by_race, lambda { |ethnicity| { :conditions => ['ethnicity = ?', ethnicity] } }
  named_scope :african_american, :conditions => ['ethnicity = ?', 1]
  named_scope :caucasian, :conditions => ['ethnicity = ?', 6]
  named_scope :by_grade, lambda { |grade| { :conditions => ['grade = ?', grade] } }
  
  # Other methods
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

 
  def new_grade
    return "" if self.grade.nil?
    # return "K" if self.grade < 1
    # self.grade
  	grades = GRADE_LIST.map{|g| g[0]}
  	grades[self.grade]
  end
  
  def make_inactive
    update_attribute(:active, false)
  end
  
end

