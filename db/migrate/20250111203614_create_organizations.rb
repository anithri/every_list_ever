class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :subtitle
      t.text :description
      t.references :user, null: false, foreign_key: true, index: true
      t.boolean :visible, default: 0

      t.timestamps
    end
  end
end
