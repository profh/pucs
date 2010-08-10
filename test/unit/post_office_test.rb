require 'test_helper'

class PostOfficeTest < ActionMailer::TestCase
  test "announcement" do
    @expected.subject = 'PostOffice#announcement'
    @expected.body    = read_fixture('announcement')
    @expected.date    = Time.now

    assert_equal @expected.encoded, PostOffice.create_announcement(@expected.date).encoded
  end

  test "profile_added" do
    @expected.subject = 'PostOffice#profile_added'
    @expected.body    = read_fixture('profile_added')
    @expected.date    = Time.now

    assert_equal @expected.encoded, PostOffice.create_profile_added(@expected.date).encoded
  end

  test "profile_revised" do
    @expected.subject = 'PostOffice#profile_revised'
    @expected.body    = read_fixture('profile_revised')
    @expected.date    = Time.now

    assert_equal @expected.encoded, PostOffice.create_profile_revised(@expected.date).encoded
  end

end
