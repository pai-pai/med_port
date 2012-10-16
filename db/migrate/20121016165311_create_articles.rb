class CreateArticles < ActiveRecord::Migration
    def self.up
        create_table :articles do |t|
            t.string :name
            t.string :translated_name
            t.text :introduction
            t.text :body
            t.belongs_to :healthcat

            t.timestamps
        end
    end

    def self.down
        drop_table :articles
    end
end
