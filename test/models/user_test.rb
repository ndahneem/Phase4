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
end
