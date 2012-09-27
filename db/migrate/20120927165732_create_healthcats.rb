class CreateHealthcats < ActiveRecord::Migration
  def change
    create_table :healthcats do |t|
      t.string :name
      t.text :description
      t.integer :parent_healthcat_id
      t.integer :gender_id

      t.timestamps
    end
  end
end
