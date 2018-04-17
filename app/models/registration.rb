class Registration < ApplicationRecord
    # relations
    belongs_to :camp
    #has_one :family, through: :student
    belongs_to :student
    
    # validation
    validates :student_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    validates :camp_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    validate :student_activity_on_system, on: :create
    validate :camp_activity_on_system, on: :create
    
    # scopes
    scope :for_camp, ->(camp_id) { where(camp_id: camp_id) }
    scope :alphabetical, -> { joins(:student).order('students.last_name, students.first_name') }
    
    
    def pay
        return false unless self.payment.nil?
        self.payment = Base64.encode64("camp: #{self.camp_id};
                                       student: #{self.student_id};
                                       amount_paid #{self.camp.cost};
                                       card_type: #{self.credit_card_type};")
        self.save!
        self.payment
    end
    
    private
    def student_activity_on_system
        return if self.student.nil?
        errors.add(:student, "is not currently active") unless self.student.active
    end
    
    def camp_activity_on_system
        return if self.camp.nil?
        errors.add(:camp, "is not currently active") unless self.camp.active
    end

  
end
