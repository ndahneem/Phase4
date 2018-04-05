class Instructor < ApplicationRecord
        has_many :camp_instructors
    has_many :camps, through: :camp_instructors 
    validates_presence_of :first_name, :last_name, :email
    validates_uniqueness_of :email
    
    # data type validations
    validates_type :first_name, :string
    validates_type :last_name, :string
    validates_type :bio, :text
    validates_type :email, :string
    validates_type :phone, :string
    validates_type :active, :boolean
    
    # scopes 
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :alphabetical, -> { order(:name)}
    scope :needs_bio, -> {where (bio ==nil)}
    
    def name
        last_name+","+first_name
    end
    
    def proper_name
        first_name + " "+ last_name
    end
    
end
