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
    scope :below_rating, ->(ceiling) { where('rating < ?', ceiling) }
    scope :at_or_above_rating, ->(floor) { where('rating >= ?', floor) }

    def name
        last_name + ", " + first_name
    end
    
    def proper_name
        first_name + " " + last_name
    end
    
    def age
        return nil if date_of_birth.blank?
        (Time.now.to_s(:number).to_i - date_of_birth.to_time.to_s(:number).to_i)/10e9.to_i
    end
    
    #call backs
    before_save :blank_rating
    
    
    before_destroy do
        check_past_camp_registration
        if errors.present?
            @destroy = false
        else
            upcoming_registrations_to_be_removed
        end
    end
    
    private
    def blank_rating
        self.rating ||= 0
    end
    
    def registered_for_past_camps?
        !self.registrations.select{|r| r.camp.start_date < Date.current}.empty?
    end
    
    def check_past_camp_registration
        return if self.registrations.empty?
        if registered_for_past_camps?
               errors.add(:base, "Student cannot be deleted! This student will be deactivated instead!")
               throw(:abort)
        end
    end

    def upcoming_registrations_to_be_removed
        return if self.registrations.empty?
        upcoming_registrations = self.registrations.select{|x| x.camp.start_date >= Date.current}
        upcoming_registrations.each{ |y| y.destroy }
    end
end
