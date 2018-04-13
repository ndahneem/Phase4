class User < ApplicationRecord
    belongs_to :family
    has_one :instructor
    
    #validations 
    validates :username, presence: true, uniqueness: { case_sensitive: false }
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validates :phone, format: { with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true }
    validates :password, :presence => true, :confirmation => true, :length => {:within => 4..40},:on => :create
    validates :password, :confirmation => true, :length => {:within => 4..40},:allow_blank => true, :on => :update

    

end
