module Contexts
  module UserContexts
      def create_users
          @noor_user   = FactoryBot.create(:user, username: "Noor", email: "ndahneem@andrew.cmu.edu", role: "instructor", phone: "412-268-2323", password: "1234", password_confirmation: "1234", active:true)
          @yasmin_user = FactoryBot.create(:user, username: "yasmin", email: "yabdelal@andrew.cmu.edu",role: "instructor", phone: "214-343-5553", password: "1234", password_confirmation: "1234", active:true)
          @aya_user    = FactoryBot.create(:user, username: "aya", email: "aaelsaka@andrew.cmu.edu", role: "instructor", phone: "214-343-5553", password: "1234", password_confirmation: "1234", active:true)
          @mark_user   = FactoryBot.create(:user, username: "Mark", email: "mark@andrew.cmu.edu",role: "instructor", phone: "214-343-5553", password: "1234", password_confirmation: "1234", active:true)
          @alex_user   = FactoryBot.create(:user, username: "Alex", email: "Alex@andrew.cmu.edu",role: "instructor", phone: "214-343-5553", password: "1234", password_confirmation: "1234", active:true)
          @rachel_user = FactoryBot.create(:user, username: "Rachel", email: "rachel@andrew.cmu.edu",role: "instructor", phone: "214-343-5553", password: "1234", password_confirmation: "1234", active:true)
      end
      
      
      def create_family_users
        @AlDahneem_user = FactoryBot.create(:user, username: "AlDahneem", email: "dahneem@andrew.cmu.edu", role: "parent", phone: "412-268-2323", password: "password", password_confirmation: "password", active:true)
        @Abdelal_user   = FactoryBot.create(:user, username: "Abdelal", email: "abdelal@andrew.cmu.edu", role: "parent", phone: "412-268-2323", password: "1234", password_confirmation: "1234", active:true)
        @Elsakka_user   = FactoryBot.create(:user, username: "Elsakka", email: "Elsakka@andrew.cmu.edu", role: "instructor", phone: "412-268-2323", password: "1234", password_confirmation: "1234", active:true)
      end
  end
end