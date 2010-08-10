require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  should_have_many :signups
  # should_have_many :guardians, :through => :signup
  
  # Validation for the date and time
  # should_allow_values_for :starting_at, "1/31/2002 10 AM ", "2/29/2004", "4:15:04 PM"
  # should_not_allow_values_for :starting_at , "2/29/2003", "12/32/2003", "4:00"
  # should_allow_values_for :ending_at, "1/31/2002 10 AM ", "2/29/2004", "4:15:04 PM"
  # should_not_allow_values_for :ending_at , "2/29/2003", "12/32/2003", "4:00"
        
end
