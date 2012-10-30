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

    factory :healthcat, :aliases => [ :categorizable ] do
        sequence(:name) { |n| "Healthcat name #{n}" }
        description { "#{'Amor non est medicabilis herbis '*300}" }
        gender { "male" }
    end

    factory :article do
        categorizable
        sequence(:name) { |n| "What 's done is done #{n}" }
        introduction { "#{'For Brutus is an honourable man; So are they all, all honourable men '*100}" }
        body { "#{'Have more than thou showest, speak less than thou knowest, lend less than thou owest '*300}" }
    end

    factory :organization do
        sequence(:name) { |n| "Hospital number #{n}" }
        address { "NN, somewhere" }
        description { "#{'Git is a crucial part of many web design & development workflows, but there are still far too many people intimidated by it. '*300}" }
    end

    factory :tag do
        sequence(:name) { |n| "Tag#{n}" }
    end
end
