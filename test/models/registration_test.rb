require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
    should belong_to(:student)
    should belong_to(:camp)
    should have_one(:family).through(:student)
    should validate_numericality_of(:camp_id).only_integer.is_greater_than(0)
    should validate_numericality_of(:student_id).only_integer.is_greater_than(0)
    
    
    context "Within context" do
    setup do 
      create_family_users
      create_families
      create_students
      create_curriculums
      create_locations
      create_camps
      create_registrations
    end
    
    
    should "have alphabetical scope working" do
        assert_equal ["AlDahneem, Amal", "AlDahneem, Reem", "AlDahneem, Reem", "Elsakkal, Farah"], Registration.alphabetical.all.map{|r| r.student.name}
    end
    
    should "have an for camp scope working" do
      assert_equal [@reem_tactics, @amal_tactics], Registration.for_camp(@camp1).sort_by{|r| r.student.last_name}
    end
    
    should "make sure student is active on system" do
        @inactive_test    = FactoryBot.create(:student, first_name: "Test",  last_name: "Test",   family: @Abdelal,   rating: 1400,  active: false , date_of_birth: 7.years.ago.to_date)
        registration_test = FactoryBot.build(:registration, student: @inactive_test, camp: @camp1)
        deny registration_test.valid?
    end
    
    should "make sure camp is active on system" do
        camp_active_test = FactoryBot.build(:registration, student: @reem, camp: @camp3)
        deny camp_active_test.valid?
    end
    
    should "know diffrent credit_card types" do
        assert @reem_tactics.valid?
        cards_test = {4123456789012=>"VISA", 4123456789012345=>"VISA", 5123456789012345=>"MC", 5412345678901234=>"MC", 6512345678901234=>"DISC", 6011123456789012=>"DISC", 30012345678901=>"DCCB", 30312345678901=>"DCCB", 341234567890123=>"AMEX", 371234567890123=>"AMEX",7123456789012=>"N/A",30612345678901=>"N/A",351234567890123=>"N/A",5612345678901234=>"N/A",6612345678901234=>"N/A"}
        cards_test.each do |card_number, name|
            @reem_tactics.credit_card_number = card_number
            assert_equal name, @reem_tactics.credit_card_type, "#{@reem_tactics.credit_card_type} :: #{@reem_tactics.credit_card_number}"
        end
    end
    
    should "validate credit_card_number" do
            @reem_tactics.expiration_month = Date.current.month + 1
            @reem_tactics.expiration_year = Date.current.year
            cards = %w[412345678901 412345678901234 512345678901234 541234567890123 651234567890123 601112345678901 3001234567890 3031234567890 34123456789012 37123456789012]
            cards.each do |num|
                @reem_tactics.credit_card_number = num
                deny @reem_tactics.valid?, "#{@reem_tactics.credit_card_number}"
            end
    end
    
    
    should " validate card expiration date" do
      assert @reem_tactics.valid?
      @reem_tactics.credit_card_number = "4123456789012"
      @reem_tactics.expiration_month = Date.current.month
      @reem_tactics.expiration_year = 1.year.ago.year
      deny @reem_tactics.valid?
      @reem_tactics.expiration_year = Date.current.year
      assert @reem_tactics.valid?
   
    end
    
    
    should "validate payment receipit" do
      @reem_tactics.payment = nil
      assert @reem_tactics.save
      @reem_tactics.credit_card_number = "4123456789012"
      @reem_tactics.expiration_month = Date.current.month + 1
      @reem_tactics.expiration_year = Date.current.year
      assert @reem_tactics.valid?
      
      @reem_tactics.pay
      assert_equal "camp:#{@reem_tactics.camp_id}; student:#{@reem_tactics.student_id}; amount_paid: #{@reem_tactics.camp.cost};card_type: #{@reem_tactics.credit_card_type}", Base64.decode64(@reem_tactics.payment)
    end
    
end
end
