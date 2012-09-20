FactoryGirl.define do
    factory :category do
        sequence(:name) { |n| "Category name #{n}" }
        description { "#{'Ave, Caesar! Morituri te salutant! '*300}" }
    end
end
