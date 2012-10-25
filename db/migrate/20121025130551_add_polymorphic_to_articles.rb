class AddPolymorphicToArticles < ActiveRecord::Migration
    def up
        change_table :articles do |t|
            t.remove :healthcat_id
            t.belongs_to :categorizable, polymorphic: true
        end

        add_index :articles, [:categorizable_id, :categorizable_type]
    end

    def down
        change_table :articles do |t|
            t.column :healthcat_id, :integer
            t.remove_belongs_to :categorizable
        end
    end
end
