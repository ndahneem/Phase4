require 'test_helper'

class UserTest < ActiveSupport::TestCase
    should have_secure_password
    
    should validate_presence_of(:username)
    #validating role
    should allow_value("admin").for(:role)
    should allow_value("parent").for(:role)
    should allow_value("instructor").for(:role)
    should_not allow_value("bad").for(:role)
    should_not allow_value("hacker").for(:role)
    should_not allow_value("hjhfjhfj").for(:role)
    should_not allow_value(nil).for(:role)
    
    # Validating email
    should allow_value("fred@fred.com").for(:email)
    should allow_value("fred@andrew.cmu.edu").for(:email)
    should allow_value("my_fred@fred.org").for(:email)
    should allow_value("fred123@fred.gov").for(:email)
    should allow_value("my.fred@fred.net").for(:email)
    
    should_not allow_value("fred").for(:email)
    should_not allow_value("fred@fred,com").for(:email)
    should_not allow_value("fred@fred.uk").for(:email)
    should_not allow_value("my fred@fred.com").for(:email)
    should_not allow_value("fred@fred.con").for(:email)
    should_not allow_value(nil).for(:email)
    
    # Validating phone
    should allow_value("4122683259").for(:phone)
    should allow_value("412-268-3259").for(:phone)
    should allow_value("412.268.3259").for(:phone)
    should allow_value("(412) 268-3259").for(:phone)
    
    should_not allow_value("2683259").for(:phone)
    should_not allow_value("4122683259x224").for(:phone)
    should_not allow_value("800-EAT-FOOD").for(:phone)
    should_not allow_value("412/268/3259").for(:phone)
    should_not allow_value("412-2683-259").for(:phone)
    should_not allow_value(nil).for(:phone)
    
    
    context "Within context" do
    setup do 
      create_users
    end
    
    should "allow user to have a unique and case-insensitive usernames" do
        assert_equal "Noor" , @noor_user.username
    end
    
    should "allow user to authenticate with password" do
        assert @noor_user.authenticate("1234")
        deny @noor_user.authenticate("password11")
    end
    
    should "not allow to create users without password" do
        no_pass_user = FactoryBot.build(:user, username: "bad user", password: nil)
        deny no_pass_user.valid?
    end
    
    should "password to be at least 4 characters" do
        short_pass_user = FactoryBot.build(:user, username: "bad", password: "no")
        deny short_pass_user.valid?
    end
    
    should "strip non-digits from the phone number" do
        assert_equal "4122682323", @noor_user.phone
    end
    
    should "confirm password if it match" do 
        userX = FactoryBot.build(:user, username: "userX", password: "some_password", password_confirmation: nil)
        deny userX.valid?
        userY = FactoryBot.build(:user, username: "userY", password: "some_password", password_confirmation: "diffrent_password")
        deny userY.valid?
    end
end

end
