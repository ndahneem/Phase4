class Student < ApplicationRecord
    # relations
    belongs_to :family
    has_many :registrations
    has_many :camps, through: :registrations
    
    
    # validation
    validates_presence_of :first_name , :last_name , :family_id
    validates :family_id, numericality: { only_integer: true, greater_than: 0 }
    ratings_array = [0] + (100..3000).to_a
    validates :rating, numericality: { only_integer: true, allow_blank: true }, inclusion: { in: ratings_array, allow_blank: true }
    validates_date :date_of_birth, :before => lambda { Date.today }, :before_message => "cannot be in the future", allow_blank: true, on: :create

    #scopes
    scope :alphabetical, -> { order('last_name','first_name') }
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    
    def name
        last_name + ", " + first_name
    end
    
    def proper_name
        first_name + " " + last_name
    end
    
    #call backs
    before_save :blank_rating
    
    private
    def blank_rating
        self.rating ||= 0
    end



end
