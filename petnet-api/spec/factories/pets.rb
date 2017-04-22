FactoryGirl.define do
    factory :pet do
        name { Faker::Name }
        animal { Faker::Color.color_name }
        breed { Faker::Cat.breed }
        created_by { Faker::Number.number(10) }
    end
end
