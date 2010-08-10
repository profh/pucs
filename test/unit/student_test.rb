require 'test_helper'

class StudentTest < ActiveSupport::TestCase

  # Shoulda Macros
  # Relationships
  should_belong_to :household
  should_have_many :guardians, :through => :household
  
  # Validating grade...
  should_allow_values_for :grade, 0, 1, 2, 3, 4, 5, 6, 7, 8
  should_not_allow_values_for :grade, "fred", -1, 3.14159, 9

  # Validating ethnicity...
  should_allow_values_for :ethnicity, 1,2,3,4,5,6
  should_not_allow_values_for :ethnicity, "fred", -1, 0, 7, 3.14159
  
  # Validating engrade id...
  should_allow_values_for :engrade_id, 1, 21, 321, 4321, 54321, 654321, 0123456
  should_not_allow_values_for :engrade_id, "fred", -1, 0, 3.14159
  
  # Validating DOB
  should_allow_values_for :dob, 8.years.ago.to_date.to_s
  should_not_allow_values_for :dob, "fred", 3.years.ago.to_date.to_s, 7.years.from_now.to_date.to_s
  
  
  # ---------------------------------
  # Testing other methods with a context
  context "Creating four students from two households" do
    # first, create the objects for each test I want with factories
    setup do 
      @heimann_family = Factory.create(:household)
      @neighbor = Factory.create(:household, :street => "10151 Sudberry Drive")
      @user1 = Factory.create(:user)
      @user2 = Factory.create(:user)
      @an = Factory.create(:guardian, :user => @user1, :household => @heimann_family)
      @larry = Factory.create(:guardian, :first_name => "Larry", :work_phone => "412-268-8211", :user => @user2, :household => @heimann_family)
      @rachel = Factory.create(:student, :household => @heimann_family)
      @craig = Factory.create(:student, :first_name => "Craig", :household => @heimann_family, :grade => 7, :dob => 12.years.ago.to_date.to_s, :is_female => false, :ethnicity => 6)
      @eric = Factory.create(:student, :first_name => "Eric", :household => @heimann_family, :grade => 7, :dob => 12.years.ago.to_date.to_s, :is_female => false, :ethnicity => 1)
      @alex = Factory.create(:student, :first_name => "Alex", :household => @neighbor, :active => false, :is_female => false, :grade => 4)
    end
    
    # and also provide a teardown method to be run after each test
    teardown do
      @heimann_family.destroy
      @neighbor.destroy
      @user1.destroy
      @user2.destroy
      @an.destroy
      @larry.destroy
      @rachel.destroy
      @craig.destroy
      @eric.destroy
      @alex.destroy
    end
  
    # now run the tests:
    # test one of each factory (not really required, but not a bad idea)
    should "show that all factories are properly created" do
      assert_equal "15090", @heimann_family.zip
      assert_equal "An", @an.first_name
      assert_equal "Larry", @larry.first_name
      assert_equal 1, @rachel.grade
      assert_equal "Craig", @craig.first_name
      assert_equal "Eric", @eric.first_name
      assert_equal "Alex", @alex.first_name
      assert @an.active
      assert @rachel.active
      deny @alex.active
    end
    
    # Test named scopes...
    # test the named scope 'all'
    should "shows that there are four students in in alphabetical order" do
      assert_equal ["Alex", "Craig", "Eric", "Rachel"], Student.all.map{|s| s.first_name}
    end
    
    # test the named scope 'active'
    should "shows that there are three active students" do
      assert_equal 3, Student.active.size
    end
    
    # test the named scope 'by_household'
    should "shows that there are three students in Heimann and one in neighbor" do
      assert_equal 3, Student.by_household(@heimann_family.id).size
      assert_equal 1, Student.by_household(@neighbor.id).size
    end
    
    # test the named scope 'girls'
    should "shows that there is one girl" do
      assert_equal 1, Student.girls.size
    end
    
    # test the named scope 'boys'
    should "shows that there are three boys" do
      assert_equal 3, Student.boys.size
    end
    
    # test the named scope 'by_race'
    should "shows that there are two mixed race children" do
      assert_equal 2, Student.by_race(5).size
    end

    # test the named scope 'african_american'
    should "shows that there is one african american child" do
      assert_equal 1, Student.african_american.size
    end

    # test the named scope 'caucasian'
    should "shows that there is one caucasian child" do
      assert_equal 1, Student.caucasian.size
    end
    
    # test the named scope 'by_grade'
    should "shows that there are two students in 7th and one both 1st and 4th" do
      assert_equal 2, Student.by_grade(7).size
      assert_equal 1, Student.by_grade(1).size
      assert_equal 1, Student.by_grade(4).size
    end
  end
end
