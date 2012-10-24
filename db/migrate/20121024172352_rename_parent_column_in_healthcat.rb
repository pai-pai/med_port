class RenameParentColumnInHealthcat < ActiveRecord::Migration
    def up
        rename_column :healthcats, :parent_healthcat_id, :parent_id
    end

    def down
        rename_column :healthcars, :parent_id, :parent_healthcat_id
    end
end
