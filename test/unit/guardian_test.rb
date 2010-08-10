require 'test_helper'

class GuardianTest < ActiveSupport::TestCase
 
  # Shoulda Macros
  # Relationships
  should_belong_to :household
  should_have_many :students, :through => :household
  
  # Validating relationship...
  should_allow_values_for :relationship, 1, 2, 3, 4, 5, 6, 7
  should_not_allow_values_for :relationship, "fred", -1, 8, 3.5
  
  # Validating ethnicity...
  should_allow_values_for :ethnicity, 1, 2, 3, 4, 5, 6 
  should_not_allow_values_for :ethnicity, "fred", -1, 0, 7
  
  # Validating email...
  should_allow_values_for :email, "fred@fred.com", "fred@andrew.cmu.edu", "my_fred@fred.org", "fred123@fred.gov", "my.fred@fred.net"
  should_not_allow_values_for :email, "fred", "fred@fred,com", "fred@fred.uk", "my fred@fred.com", "fred@fred.con"

  # Validating phones...
  should_allow_values_for :mobile_phone, "4122683259", "412-268-3259", "412.268.3259", "(412) 268-3259"
  should_not_allow_values_for :mobile_phone, "2683259", "4122683259x224", "800-EAT-FOOD", "412/268/3259", "412-2683-259", "41-2268-3259"
  should_allow_values_for :work_phone, "4122683259", "412-268-3259", "412.268.3259", "(412) 268-3259"
  should_not_allow_values_for :work_phone, "2683259", "4122683259x224", "800-EAT-FOOD", "412/268/3259", "412-2683-259", "41-2268-3259"
  
  # Testing other methods with a context
  context "Creating four guardians from three households" do
    # first, create the objects for each test I want with factories
    setup do 
      @heimanns = Factory.create(:household)
      @neighbor1 = Factory.create(:household, :street => "10151 Sudberry Drive")
      @neighbor2 = Factory.create(:household, :street => "10153 Sudberry Drive")
      @user1 = Factory.create(:user)
      @user2 = Factory.create(:user)
      @user3 = Factory.create(:user)
      @user4 = Factory.create(:user)
      @an = Factory.create(:guardian, :user => @user1, :household => @heimanns)
      @larry = Factory.create(:guardian, :first_name => "Larry", :work_phone => "412-268-8211", :user => @user2, 		:household => @heimanns, :relationship => 2, :ethnicity => 6, :is_primary => false)
      @clyde = Factory.create(:guardian, :first_name => "Clyde", :mobile_phone => "(412) 268-3259", :user => 			@user3, :household => @neighbor1, :relationship => 2, :ethnicity => 1, :active => false)
      @grannie = Factory.create(:guardian, :first_name => "Grannie", :user => @user4, :household => @neighbor2, 		:relationship => 3, :ethnicity => 1)
    end
    
    # and also provide a teardown method to be run after each test
    teardown do
      @heimanns.destroy
      @neighbor1.destroy
      @neighbor2.destroy
      @user1.destroy
      @user2.destroy
      @user3.destroy
      @user4.destroy
      @an.destroy
      @larry.destroy
      @clyde.destroy
      @grannie.destroy
    end
  
    # now run the tests:
    # test named scopes first...
    # test the named scope 'all'
    should "shows that there are four guardians in alphabetical order" do
	assert_equal ["An", "Clyde", "Grannie", "Larry"], Guardian.all.map{|g| g.first_name}
    end
    
    # test the named scope 'active'
    should "shows that there are three active guardians" do
	assert_equal 3, Guardian.active.size
    end
    
    # test the named scope 'primary'
    should "shows that there are three primary guardians" do
	assert_equal 3, Guardian.primary.size

    end
    
    # test the named scope 'by_household'
    should "shows that there are two guardians at the Heimanns and one in each neighbor's home" do
	 assert_equal 2, Guardian.by_household(@heimanns.id).size
     assert_equal 1, Guardian.by_household(@neighbor1.id).size
	 assert_equal 1, Guardian.by_household(@neighbor2.id).size

    end
    
    # test the named scope 'by_relationship'
    should "shows that there are 2 dads, a mom and a grandmother" do
	assert_equal 2, Guardian.by_relationship(2).size
	assert_equal 1, Guardian.by_relationship(1).size
	assert_equal 1, Guardian.by_relationship(3).size


    end
    
    
    # test the named scope 'by_race'
    should "shows that there are 2 african americans, one asian, and one white guy" do
	assert_equal 2, Guardian.by_race(1).size
	assert_equal 1, Guardian.by_race(3).size
	assert_equal 1, Guardian.by_race(6).size

    end
    
    # test other methods...
    # test the reformatting phone callback is working
    should "shows that both types of phones are stripped of non-digits" do
	assert_equal "4122688211", @larry.work_phone
	assert_equal "4122683259", @clyde.mobile_phone

    end
  end
end
  
 