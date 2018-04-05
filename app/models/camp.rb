class Camp < ApplicationRecord
        has_many :camp_instructors
    belongs_to :location
    belongs_to :curriculum
    has_many :instructors, through: :camp_instructors
    validates_presence_of :curriculum_id, :location_id, :start_date, :end_date, :time_slot
    validates max_students <= location.max_capacity

    # validate data type 
    validates_type :curriculum_id, :integer
    validates_type :location_id, :integer
    validates_type :cost, :float
    validates_type :start_date, :date
    validates_type :end_date, :date
    validates_type :time_slot, :string
    validates_type :max_students, :integer
    validates_type :active, :boolean
    
    #scopes
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :alphabetical, -> { order(:curriculum.name)}
    scope :chronological, -> { order(:start_date, :end_date) }
    scope :morning, -> {where (:time_slot =='am')}
    scope :afternoon, -> {where (:time_slot =='pm')}
    
    def name
        curriculum_id.name
    end
    
end
