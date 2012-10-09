class CreatePlacings < ActiveRecord::Migration
    def self.up
        create_table :placings do |t|
            t.belongs_to :healthcat
            t.belongs_to :bodypart
            t.timestamps
        end
    end

    def self.down
        drop_table :placing
    end
end
