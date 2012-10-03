class AddTranslatedNameToHealthcats < ActiveRecord::Migration
    def self.up
        add_column :healthcats, :translated_name, :string
    end

    def self.down
        remove_column :healthcats, :translated_name
    end
end
