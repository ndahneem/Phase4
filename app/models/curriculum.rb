class Curriculum < ApplicationRecord
    has_many :camps
    validates_presence_of :name, :min_rating , :max_rating , :description , :active
    validates_uniqueness_of :name 
    validates_numericality_of :min_rating , :only_integer => true,:greater_than_or_equal_to => 0
    validates_numericality_of :max_rating , :only_integer => true,:less_than_or_equal_to => 3000
    # data type validations 
    validates_type :name, :string
    validates_type :min_rating , :integer
    validates_type :max_rating , :integer
    validates_type :active, :boolean
    validates_type :description, :text
    # scopes 
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :alphabetical, -> { order(:name)}
    
end
