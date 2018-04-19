require 'test_helper'

class InstructorTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:camp_instructors)
  should have_many(:camps).through(:camp_instructors)

  # test validations
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)


  # set up context
  context "Within context" do
    setup do 
      create_users
      create_instructors
    end
    
    # teardown do
    #   delete_instructors
    # end

    should "show that there are three instructors in alphabetical order" do
      assert_equal ["Alex", "Mark", "Rachel"], Instructor.alphabetical.all.map(&:first_name)
    end

    should "show that there are two active instructors" do
      assert_equal 2, Instructor.active.size
      assert_equal ["Alex", "Mark"], Instructor.active.all.map(&:first_name).sort
    end
    
    should "show that there is one inactive instructor" do
      assert_equal 1, Instructor.inactive.size
      assert_equal ["Rachel"], Instructor.inactive.all.map(&:first_name).sort
    end

    should "show that there are two instructors needing bios" do
      assert_equal 2, Instructor.needs_bio.size
      assert_equal ["Alex", "Rachel"], Instructor.needs_bio.all.map(&:first_name).sort
    end

    should "show that name method works" do
      assert_equal "Heimann, Mark", @mark.name
      assert_equal "Heimann, Alex", @alex.name
    end
    
    should "show that proper_name method works" do
      assert_equal "Mark Heimann", @mark.proper_name
      assert_equal "Alex Heimann", @alex.proper_name
    end

    # test the callback is working 'reformat_phone'
    # should "shows that Alex's phone is stripped of non-digits" do
    #   assert_equal "4122688211", @alex.phone
    # end

    should "have a class method to give array of instructors for a given camp" do
      # create additional contexts that are needed
      create_curriculums
      create_active_locations
      create_camps
      create_camp_instructors
      assert_equal ["Alex", "Mark"], Instructor.for_camp(@camp1).map(&:first_name).sort
      assert_equal ["Mark"], Instructor.for_camp(@camp4).map(&:first_name).sort
      # remove those additional contexts
      # delete_camp_instructors
      # delete_curriculums
      # delete_active_locations
      # delete_camps
    end
  
  
    should "allow instructor to be destroyed if did not taught past camps" do
      # assert @alex.camps.past.empty?
      # assert @alex.destroy
      @test_user   = FactoryBot.create(:user, username: "test", email: "test@andrew.cmu.edu", role: "instructor", phone: "412-268-2323", password: "1234", password_confirmation: "1234", active:true)
      @test = FactoryBot.create(:instructor, first_name: "Test", last_name: "Test", bio: "tessttttt", user: @test_user, active: true)
      assert @test.camps.past.empty?
      assert @test.destroy
    end
    
    should "not allow instructor to be destroyed if taught past camps" do
      create_curriculums
      create_active_locations
      create_camps
      create_camp_instructors
      @camp1.update_attribute(:start_date, 32.weeks.ago.to_date)
      @camp1.update_attribute(:end_date, 31.weeks.ago.to_date)
      deny @alex.camps.past.empty? 
      deny @alex.camps.upcoming.empty?
      
    end
    
    # should " have user account deactivated if instructor made inactive" do
    #   @alex.active = false
    #   @alex.save
    #   deny @alex.user.active
    # end
  end
end
