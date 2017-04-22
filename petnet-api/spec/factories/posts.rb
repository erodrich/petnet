FactoryGirl.define do
    factory :post do
        title { Faker::StarWars.character }
        content { Faker::Lorem.paragraph }
        active false
        pet_id nil
    end
end