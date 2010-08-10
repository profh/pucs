class User < ActiveRecord::Base
  acts_as_authentic
  before_validation_on_create :add_random_password
  
  # acts_as_authentic do |nu|
  #   nu.validate_password_field = false
  # end

  has_one :guardian, :dependent => :destroy
  has_one :administrator
  
  ROLES = [['Administrator', :admin],['Guardian', :guardian],['Teacher', :teacher]]
  
  def role?(authorized_role)
    return false if role.nil?
    role.to_sym == authorized_role
  end
  
  def admin?
    return true if self.role=="admin"
    false
  end
  
  def deliver_password_reset_instructions!  
    #reset_perishable_token!
    PostOffice.deliver_password_reset_instructions(self)  
  end
  
  private
  def add_random_password
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("1".."9").to_a 
 		newpass = Array.new(10, '').collect{chars[rand(chars.size)]}.join
 		self.password = newpass
 		self.password_confirmation = newpass
 		self.temp_pswd = newpass
  end 
end


#a.guardians_attributes=[{:first_name=>"Fred",:last_name=>"Derf",:user_attributes=>{:username=>"fred",:email=>"fred@fred.com"}}]