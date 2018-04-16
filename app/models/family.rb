class Family < ApplicationRecord
    #relationships
    belongs_to :user
    has_many :students
    #validations
    validates_presence_of :family_name , :parent_first_name
    
    #scopes
    scope :alphabetical, -> { order('family_name') }
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    
    before_destroy :never_destroy
    
    def never_destroy
        errors.add(:family,"cannot destroy record")
        throw(:abort)
    end
    
    
    
end
