module Contexts
  module RegistrationContexts
    def create_registrations
      @reem_tactics    = FactoryBot.create(:registration, camp: @camp1, student: @reem)
      @reem_endgames = FactoryBot.create(:registration, camp: @camp4, student: @reem)
      @amal_tactics  = FactoryBot.create(:registration, camp: @camp1, student: @amal)
      @farah_endgames  = FactoryBot.create(:registration, camp: @camp4, student: @farah)
 
    end
      
  end
end