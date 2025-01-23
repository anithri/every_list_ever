class CreateRoleTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :role_types do |t|
      t.string :name, null: false, index: { unique: true }
      t.integer :order, null: false, default: 0
    end
  end
end
