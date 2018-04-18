class Registration < ApplicationRecord
    # relations
    belongs_to :camp
    belongs_to :student
    # credit card validations
    attr_accessor :card_number
    attr_accessor :expiration_year
    attr_accessor :expiration_month
    
    # validation
    validates :student_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    validates :camp_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    validate :student_activity_on_system, on: :create
    validate :camp_activity_on_system, on: :create
    #validates :credit_card_match , on: :create
    #validates :expiration_check , on: :create
    
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
    
    def credit_card_match
        if self.card_number.to_s.match("/4[0-9]{12}(?:[0-9]{3})?/") and (self.card_number.to_s.length ==16 ||self.card_number.to_s.length ==13)
            "VISA"
        elsif self.card_number.to_s.match("/^5[1-5][0-9]{14}$/") and (self.card_number.to_s.length ==16)
            "MC"
        elsif self.card_number.to_s.match("/^6(?:011|5[0-9]{2})[0-9]{12}$/") and (self.card_number.to_s.length ==16)
            "DISC"
        elsif self.card_number.to_s.match("/^3(?:0[0-5]|[68][0-9])[0-9]{11}$/") and (self.card_number.to_s.length ==14)
            "DCCB"
        elsif self.card_number.to_s.match("/^3[47][0-9]{13}$/") and (self.card_number.to_s.length ==15)   
            "AMEX"
        else
            "Credit Card Number is invalid"
        end
    end
    
    def expiration_check
        if self.expiration_year >= Date.today.year && self.expiration_month >= Time.now.month
            return true
        else
            return false
        end
    end

  
end
