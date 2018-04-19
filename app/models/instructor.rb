class Instructor < ApplicationRecord
  # relationships
  has_many :camp_instructors
  has_many :camps, through: :camp_instructors
  belongs_to :user

  # validations
  validates_presence_of :first_name, :last_name
  #validates :email, presence: true, uniqueness: { case_sensitive: false}, format: { with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format" }
  #validates :phone, format: { with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true }


  # scopes
  scope :alphabetical, -> { order('last_name, first_name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :needs_bio, -> { where('bio IS NULL') }
  # scope :needs_bio, -> { where(bio: nil) }  # this also works...

  # class methods
  def self.for_camp(camp)
    # the 'instructive way'... (which I told you if you asked me for help)
    CampInstructor.where(camp_id: camp.id).map{ |ci| ci.instructor }
    # the easy way... 
    # camp.instructors
  end
  
  # callbacks
  #   before_destroy do
  #   instructor_taught_past_camps
  #   if errors.present?
  #     @destroy = false
  #     throw(:abort)
  #   else
  #     self.user.destroy
  #   end
  # end
  
  before_destroy :instructor_taught_past_camps
  before_update :deactivate_user_if_instructor_made_inactive
  # instance methods
  def name
    last_name + ", " + first_name
  end
  
  def proper_name
    first_name + " " + last_name
  end
  

  
  def instructor_taught_past_camps
     if self.camps.past.empty?
        @destroy = false
        errors.add(:base, 'unable to delete instructor becuase this instructor have taught past camps')
    end
  end
  
  
  # def deactivate_user_if_instructor_made_inactive
  #       if !self.active && !self.user.nil?
  #         self.user.active = false
  #         self.user.save
  #       end
    
  # end
    
end
