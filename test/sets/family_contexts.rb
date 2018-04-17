module Contexts
  module FamilyContexts
      def create_families
        @AlDahneem = FactoryBot.create(:family , family_name:"AlDahneem", parent_first_name:"Adel",user: @AlDahneem_user, active: true)
        @Abdelal   = FactoryBot.create(:family , family_name:"Abdelal", parent_first_name:"Hassan",user: @Abdelal_user, active: true)
        @Elsakka   = FactoryBot.create(:family , family_name:"Elsakka", parent_first_name:"Ali",user: @Elsakka_user, active: false)
      end
  end
end