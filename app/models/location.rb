class Location < ApplicationRecord
    has_many :camps
    validates_presence_of :name, :street_1, :city, :state, :zip, :max_capacity, :active
    validates_uniqueness_of :name
    validates_length_of :zip, :minimum => 5, :maximum => 5
    
    # data type validations
    validates_type :name, :string
    validates_type :street_1, :string
    validates_type :street_2, :string
    validates_type :city, :string
    validates_type :state, :string
    validates_type :zip, :string
    validates_type :max_capacity , :integer
    validates_type :active, :boolean
    
    #scopes
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :alphabetical, -> { order(:name)}
end
