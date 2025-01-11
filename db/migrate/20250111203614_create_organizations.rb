class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :subtitle
      t.text :description
      t.references :owner, null: false, foreign_key: true
      t.boolean :visible

      t.timestamps
    end
  end
end
