require 'test_helper'

class CurriculumTest < ActiveSupport::TestCase
  # TODO: Relationship macros
  #should have_many(:camps)
  # TODO: Validation macros
  should validate_presence_of(:name)
  should validate_presence_of(:min_rating)
  should validate_presence_of(:max_rating)
  should validate_presence_of(:description)
  should validate_presence_of(:active)
  # TODO: Context testing
  setup do
      create_curriculums
    end
    
  teardown do
      destroy_curriculums
  end

end
