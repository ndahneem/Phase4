class CampInstructor < ApplicationRecord
    belongs_to :instructor
    belongs_to :camp
    validates_presence_of :camp_id , :instructor_id
    validates_uniqueness_of :camp_id , :instructor_id
    
    # data type validation 
    validates_type :camp_id, :integer
    validates_type :instructor_id, :integer
    
    camp_id belongs_to instructor_id,-> where(active: true)
    instructor_id belongs_to camp_id,->where(active: true)
end
