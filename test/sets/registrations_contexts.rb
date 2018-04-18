module Contexts
  module RegistrationContexts
    def create_registrations
      @reem_tactics    = FactoryBot.create(:registration, camp: @camp1, student: @reem)
    end
      
  end
end