require 'test_helper'

class HouseholdTest < ActiveSupport::TestCase
  # Shoulda Macros
  # Relationships
  should_have_many :guardians
  should_have_many :students
  
  # Validating ethnicity...
  should_allow_values_for :status, 1, 2
  should_not_allow_values_for :status, -1, 0, 3
  
  # Validating state...
  should_allow_values_for :state, "PA", "WV", "OH"
  should_not_allow_values_for :state, "CA", "IL"
  
  # Validating city...
  should_allow_values_for :city, "Los Angeles", "St. Louis", "Fairfax", "San-Antonio"
  should_not_allow_values_for :city, "84", "fred#fred", "Santa/Fe", "Santa~Fe"
  
  # Validating home phone...
  should_allow_values_for :home_phone, "1234567890", "123-456-7890", "123.456.7890", "(123) 456-7890", "(123) 456.7890", "(123).456.7890", "(123)4567890"
  should_not_allow_values_for :home_phone, "12345", "123456778899", "12-3456-7890", "#1234567890", "123_456_7890", "(1234) 567890", "123 456 7890"
  
  # ---------------------------------
  # Testing other methods with a context
  context "Creating four households" do
    # first, create the objects for each test I want with factories
    setup do 
      @heimanns = Factory.create(:household, :street => "100 Main", :active => false)
      @mitchuals = Factory.create(:household, :street => "200 Main", :zip => "15213", :free_lunch => false)
      @pipers = Factory.create(:household, :street => "300 Main", :zip => "15212", :free_lunch => false, :status => 1)
      @mitchells = Factory.create(:household, :street => "400 Main", :zip => "15237", :home_phone => "412.268.8211")
    end
    
    # and also provide a teardown method to be run after each test
    teardown do
      @heimanns.destroy
      @mitchuals.destroy
      @pipers.destroy
      @mitchells.destroy
    end
  
    # now run the tests:
    # test named scopes first...
    # test the named scope 'all'
    should "shows that there are four households in in alphabetical order by address" do
      assert_equal ["100 Main", "200 Main", "300 Main", "400 Main"], Household.all.map{|h| h.street}
    end
    
    # test the named scope 'active'
    should "shows that there are three active households" do
      assert_equal 3, Household.active.size
    end
    
    # test the named scope 'free_lunch'
    should "shows that there are two households in free lunch program" do
      assert_equal 2, Household.free_lunch.size
    end
    
    # test the named scope 'single_parent'
    should "shows that there is one single parent household" do
      assert_equal 1, Household.single_parent.size
    end
    
    
    # test the named scope 'two_parent'
    should "shows that there are three two parent households" do
      assert_equal 3, Household.two_parent.size
    end
    
    # now test other methods...
    # test the reformatting phone callback is working properly
    should "shows that home phone is stripped of non-digits" do
      assert_equal "4122688211", @mitchells.home_phone
    end
  end
end
