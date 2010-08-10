
# FACTORIES FOR PUCS 
# -------------------------------

# Create factory for Guardian class
  Factory.define :guardian do |g|
    g.first_name "An"
    g.last_name "Heimann"
    g.association :household
    g.is_primary true
    g.relationship 1
    g.is_female true
    g.ethnicity 3
    g.email { |a| "#{a.first_name}.#{a.last_name}@example.com".downcase }
    g.mobile_phone { rand(10 ** 10).to_s.rjust(10,'0') }
    g.work_phone { rand(10 ** 10).to_s.rjust(10,'0') }
    g.association :user
    g.security_form true
    g.active true
  end

# Create factory for Student class
  Factory.define :student do |s|
    s.first_name "Rachel"
    s.last_name "Heimann"
    s.association :household
    s.grade 1
    s.dob 7.years.ago.to_date.to_s
    s.ethnicity 5
    s.is_female true
    s.engrade_id { rand(5 ** 10).to_s.rjust(7,'0') }
    s.active true    
  end
    
# Create factory for Household class
  Factory.define :household do |h|
    h.street "10152 Sudberry Drive"
    h.city "Wexford"
    h.state "PA"
    h.zip "15090"
    h.home_phone { rand(10 ** 10).to_s.rjust(10,'0') }
    h.free_lunch true
    h.status 2
    h.active true
  end
  

# Create factory for User class
  Factory.define :user do |u|
    # if we create multiple users, automatically add a incremented number
    u.sequence(:username) { |n| "fred_#{n}" }   
    u.password "fred_lives"  
    u.password_confirmation { |u| u.password }  
    # as above, automatically add a incremented number to email prefix
    u.sequence(:email) { |n| "fred#{n}@example.com" }
  end
