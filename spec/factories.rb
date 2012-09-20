Factory.define :category do |f|
    f.sequence(:name) { |n| "Category name #{n}" }
    f.description { "#{'Ave, Caesar! Morituri te salutant! '*300}" }
end
