require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # relationships
  should belong_to(:family)
  should have_many(:registrations)
  should have_many(:camps).through(:registrations)
  
  # Validations
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:family_id)
  should validate_numericality_of(:family_id).only_integer.is_greater_than(0)
  
  # validate date of birth
  should allow_value(18.years.ago.to_date).for(:date_of_birth)
  should allow_value(5.years.ago.to_date).for(:date_of_birth)
  should_not allow_value(Date.today).for(:date_of_birth)
  should_not allow_value(1.day.from_now.to_date).for(:date_of_birth)
  should_not allow_value("bad").for(:date_of_birth)
  should_not allow_value(2).for(:date_of_birth)
  should_not allow_value(3.14159).for(:date_of_birth)
  
  # validate rating
  should_not allow_value(3001).for(:rating)
  should_not allow_value(-1).for(:rating)
  should_not allow_value(500.50).for(:rating)
  should_not allow_value("bad").for(:rating)
  should allow_value(1000).for(:rating)
  should allow_value(100).for(:rating)
  should allow_value(2872).for(:rating)
  should allow_value(0).for(:rating)
  should allow_value(nil).for(:rating)
  

end
