require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  should belong_to(:user)
  should have_many(:students)
  should validate_presence_of(:family_name)
  should validate_presence_of(:parent_first_name)
  should have_many(:registrations).through(:students)

  
  context "Within context" do
    setup do 
      create_family_users
      create_families
      
    end
    
  should "sort families in alphabetical order" do
    assert_equal %w[Abdelal AlDahneem Elsakka], Family.alphabetical.all.map(&:family_name)
  end
  
  should "shows that there are two active families" do
      assert_equal 2, Family.active.size
      assert_equal ["Abdelal", "AlDahneem"], Family.active.all.map{|c| c.family_name}.sort
  end 
  
  should "show that there is one inactive family" do
    assert_equal 1 , Family.inactive.size
    assert_equal ["Elsakka"], Family.inactive.all.map{|c| c.family_name}.sort
  end
  
  should "never destroy a family" do
    deny @AlDahneem.destroy
  end
  
  should "remove upcoming regisrtation when family is inactive" do
      create_curriculums
      create_locations
      create_camps
      create_students
      create_registrations
      assert_equal 3, @AlDahneem.registrations.count
      @AlDahneem.update_attribute(:active, false)
      @AlDahneem.reload
      assert_equal 0, @AlDahneem.registrations.count
      


  end
    
    
    
  end
    
end
