class Registration < ApplicationRecord
    
    #require 'base64'
    # relations
    belongs_to :camp
    belongs_to :student
    has_one :family, through: :student
    # credit card validations
    attr_accessor :credit_card_number
    attr_accessor :expiration_year
    attr_accessor :expiration_month
    
    # validation
    validates :student_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    validates :camp_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    validate :student_activity_on_system, on: :create
    validate :camp_activity_on_system, on: :create
    validate :card_number_is_valid
    validate :expiration_date_is_valid
    
    # scopes
    scope :for_camp, ->(camp_id) { where(camp_id: camp_id) }
    scope :alphabetical, -> { joins(:student).order('students.last_name, students.first_name') }
    
    def pay
        return false unless self.payment.nil?
        self.payment = Base64.encode64("camp:#{self.camp_id}; student:#{self.student_id}; amount_paid: #{self.camp.cost};card_type: #{self.credit_card_type}")
                                       
        
        self.save!
        self.payment
    end
    
    
    def credit_card_type
        credit_card.type.nil? ? "N/A" : credit_card.type.name
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
    
    
    def credit_card
        CreditCard.new(self.credit_card_number, self.expiration_year, self.expiration_month)
    end
    
    def card_number_is_valid
        return false if self.expiration_year.nil? || self.expiration_month.nil?
        if self.credit_card_number.nil? || credit_card.type.nil?
          errors.add(:credit_card_number, "is not valid")
          return false
        end
        
    end
    
    def expiration_date_is_valid
        return false if self.credit_card_number.nil? 
        if self.expiration_year.nil? || self.expiration_month.nil? || credit_card.expired?
            errors.add(:expiration_year, "is expired")
            return false
        end
       
    end
  
end
