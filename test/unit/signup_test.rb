require 'test_helper'

class SignupTest < ActiveSupport::TestCase
  #Shoulda Macros 
  #Testing the relationshoips
  
  should_belong_to :guardian
  should_belong_to :event
 

end
