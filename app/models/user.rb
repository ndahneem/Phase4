class User < ApplicationRecord
    # for password hashing
    
    has_secure_password 
    # relationships
    has_one :instructor
    has_one :family

    
    #role list
    ROLE_LIST = [['admin','admin'],['parent','parent'],['instructor','instructor']]
    
    #validations 
    validates :username, presence: true, uniqueness: { case_sensitive: false}
    validates :email, presence: true, uniqueness: { case_sensitive: false}, format: { with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format" }
    validates :phone,presence: true, format: { with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true }
    validates :role, inclusion: { in: %w[admin instructor parent], message: "is not a recognized role in system" }
    #password
    validates_presence_of :password, on: :create 
    validates_presence_of :password_confirmation, on: :create
    validates_length_of :password, minimum: 4, message: "must be at least 4 characters long", allow_blank: true
    validates_confirmation_of :password, message: "does not match"


    
    # callbacks
    before_save :reformat_phone
    
    private
    def reformat_phone
        phone = self.phone.to_s  # change to string in case input as all numbers 
        phone.gsub!(/[^0-9]/,"") # strip all non-digits
        self.phone = phone       # reset self.phone to new string
    end
    
    

end
