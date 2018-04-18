module Contexts
  module StudentContexts
      def create_students
          @reem   = FactoryBot.create(:student, first_name: "Reem", last_name: "AlDahneem", family: @AlDahneem, rating: 100,  active: true)
          @amal   = FactoryBot.create(:student, first_name: "Amal", last_name: "AlDahneem", family: @AlDahneem, rating: 1804, active: true)
          @aya    = FactoryBot.create(:student, first_name: "Aya",  last_name: "Abdelal",   family: @Abdelal,   rating: 1400,  active: false , date_of_birth: 7.years.ago.to_date)
          @farah    = FactoryBot.create(:student, first_name: "Farah",  last_name: "Elsakkal", family: @Elsakka,   rating: 300,  active: true , date_of_birth: 10.years.ago.to_date)
      end
      
      
  end
end