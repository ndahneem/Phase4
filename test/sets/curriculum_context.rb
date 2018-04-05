module Contexts
    module CurriculumContext
        def create_curriculums
            @c1 = FactoryBot.create(:curriculum)
            @c2 = FactoryBot.create(:curriculum, name: "Something" ,active: false)
            @c3 = FactoryBot.create(:curriculum, name: "Aya curriculum", min_rating: 20)
            @c4 = FactoryBot.create(:curriculum,name: "Yasmin curriculum", max_rating: 150)
            @c5 = FactoryBot.create(:curriculum ,min_rating: 10 , max_rating: 30)
        end
        def destroy_curriculums
            @c1.destroy
            @c2.destroy
            @c3.destroy
            @c4.destroy
            @c5.destroy
        end
        
        
    end
end