class ChangeHealthcats < ActiveRecord::Migration
    def up
        rename_column :healthcats, :gender_id, :gender
        change_column :healthcats, :gender, :string
    end

    def down
        rename_column :healthcats, :gender, :gender_id
        change_column :healthcats, :gender_id, :integer
    end
end
