require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # relationships
  should belong_to(:family)
  should have_many(:registrations)
  should have_many(:camps).through(:registrations)
  
  # Validations
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:family_id)
  should validate_numericality_of(:family_id).only_integer.is_greater_than(0)
  
  # validate date of birth
  should allow_value(18.years.ago.to_date).for(:date_of_birth)
  should allow_value(5.years.ago.to_date).for(:date_of_birth)
  should_not allow_value(Date.today).for(:date_of_birth)
  should_not allow_value(1.day.from_now.to_date).for(:date_of_birth)
  should_not allow_value("bad").for(:date_of_birth)
  should_not allow_value(2).for(:date_of_birth)
  should_not allow_value(3.14159).for(:date_of_birth)
  
  # validate rating
  should_not allow_value(3001).for(:rating)
  should_not allow_value(-1).for(:rating)
  should_not allow_value(500.50).for(:rating)
  should_not allow_value("bad").for(:rating)
  should allow_value(1000).for(:rating)
  should allow_value(100).for(:rating)
  should allow_value(2872).for(:rating)
  should allow_value(0).for(:rating)
  should allow_value(nil).for(:rating)
  
  context "Within context" do
      setup do 
        create_family_users
        create_families
        create_students
      end
      
      should "fill blank rating with 0" do
          @shouq = FactoryBot.create(:student, family: @AlDahneem, first_name: "Shouq", last_name: "AlDahneem", date_of_birth: 9.years.ago.to_date, active: false, rating: nil)
          assert_equal 0, @shouq.rating
      end
      
      should "validate name method is working" do
        assert_equal "AlDahneem, Reem", @reem.name
        assert_equal "AlDahneem, Amal", @amal.name
      end
      
      should "validate proper name method is working" do
        assert_equal "Reem AlDahneem", @reem.proper_name
        assert_equal "Amal AlDahneem", @amal.proper_name
      end
      
      
      should "validate age method is working" do 
        assert_equal 10, @farah.age  
        assert_equal 7, @aya.age    
      end
      
      should "sort students in alphabetical order" do
        assert_equal ["Abdelal, Aya", "AlDahneem, Amal", "AlDahneem, Reem", "Elsakkal, Farah"], Student.alphabetical.all.map(&:name)
      end
      
      should "show 3 active students" do
        assert_equal 3, Student.active.size
        assert_equal ["Reem", "Amal", "Farah"], Student.active.all.map(&:first_name)
      end
      
      should "show 1 inactive student" do
        assert_equal 1, Student.inactive.size
        assert_equal ["Aya"], Student.inactive.all.map(&:first_name)
      end
      
      should "validate below rating scope is working" do |rating|
        assert_equal 2, Student.below_rating(1000).size
        assert_equal ["Reem","Farah"], Student.below_rating(1000).all.map(&:first_name) 
      end
      
      should "validate at_or_above_rating scope is working" do |rating|
        assert_equal 2, Student.at_or_above_rating(1000).size
        assert_equal ["Amal","Aya"], Student.at_or_above_rating(1000).all.map(&:first_name) 
      end
      
      should "allow student with no past camps to be destroyed" do
        assert @amal.destroy
      end
      
      should "deactivate student with past camps and not destroy" do
        create_curriculums
        create_locations
        create_camps
        create_registrations
        @camp1.update_attribute(:start_date, 40.weeks.ago.to_date)
        @camp1.update_attribute(:end_date, 30.weeks.ago.to_date)
        assert_equal 2, @camp4.registrations.count
        assert_equal 2, @reem.registrations.count
        deny @reem.destroy
        @camp4.reload
        deny @reem.active
        assert_equal 1, @camp4.registrations.count
        assert_equal 1, @reem.registrations.count
      end
      
      
      should "remove_upcoming_registrations if student deactivated" do
        create_curriculums
        create_locations
        create_camps
        create_registrations
        assert_equal 2, @camp1.registrations.count
        assert_equal 2, @reem.registrations.count
        @reem.update_attribute(:active, false)
        @reem.reload
        deny @reem.active
        assert_equal 1, @camp1.registrations.count
        assert_equal 0, @reem.registrations.count

      end
  end
    

  
  
end
