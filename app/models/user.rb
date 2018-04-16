class User < ApplicationRecord
    # for password hashing
    
    has_secure_password 
    # relationships
    # belongs_to :family
    # belongs_to :instructor
    
    #role list
    ROLE_LIST = [['admin','admin'],['parent','parent'],['instructor','instructor']]
    
    #validations 
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    validates :email, presence: true, uniqueness: { case_sensitive: false}, format: { with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format" }
    validates :phone, format: { with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true }
    validates :role, inclusion: { in: %w[admin instructor parent], message: "is not a recognized role in system" }
    validates_length_of :password, minimum: 4, message: "must be at least 4 characters long", allow_blank: true
    validates_presence_of :password, on: :create 
    validates_presence_of :password_confirmation, on: :create
    # validates :password_digest, :presence => true, :confirmation => true, :length => {:within => 4..40},:on => :create
    # validates :password_digest, :confirmation => true, :length => {:within => 4..40},:allow_blank => true, :on => :update
    
    
    #methods
    def role?(authorized_role)
        return false if role.nil?
        role.downcase.to_sym == authorized_role
    end
    
    # callbacks
    before_save :reformat_phone
    
    private
    def reformat_phone
        phone = self.phone.to_s  # change to string in case input as all numbers 
        phone.gsub!(/[^0-9]/,"") # strip all non-digits
        self.phone = phone       # reset self.phone to new string
    end
    
    

end
