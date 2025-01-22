class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :subtitle
      t.text :description
      t.boolean :visible, default: 'f', null: false
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
