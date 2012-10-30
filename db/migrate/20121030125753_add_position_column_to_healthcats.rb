class AddPositionColumnToHealthcats < ActiveRecord::Migration
    def up
        add_column :healthcats, :position, :integer
    end

    def down
        remove_column :healthcats, :position
    end
end
