FactoryGirl.define do
    factory :user do
        sequence(:email) { |n| "user#{n}@example.com" }
        password "password"
        password_confirmation { |u| u.password}
        admin false
    end

    factory :admin, class: User do
        sequence(:email) { |n| "admin#{n}@example.com" }
        password "password"
        password_confirmation { |u| u.password}
        admin true
    end

    factory :bodypart do
        sequence(:name) { |n| "Bodypart name #{n}" }
    end

    factory :category do
        sequence(:name) { |n| "Category name #{n}" }
        description { "#{'Ave, Caesar! Morituri te salutant! '*300}" }
    end

    factory :healthcat do
        sequence(:name) { |n| "Healthcat name #{n}" }
        description { "#{'Amor non est medicabilis herbis '*300}" }
        gender { "male" }
    end
end
