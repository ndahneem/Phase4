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
end
