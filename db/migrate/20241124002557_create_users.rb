class CreateUsers < ActiveRecord::Migration[8.0]

  def change
    create_table :users do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :email, null: false, index: { unique: true }
      t.boolean :visible, null: false, default: "false", index: true
      t.integer :site_role, null: false, default: 0, index: true
      t.string :location
      t.text :description
      t.string :avatar_url
      t.json :settings, default: { "theme": "light" }, null: false
      t.string :encrypted_password, limit: 128, null: false
      t.string :confirmation_token, limit: 128, index: { unique: true, length: 128 }
      t.string :remember_token, limit: 128, null: false, index: { unique: true, length: 128 }
      t.timestamps null: false
      t.datetime :confirmed_at # indicies added below
      t.datetime :deleted_at # indicies added below
    end

    add_index :users, :confirmed_at, name: "index_users_on_confirmed_at_null", where: "deleted_at IS NULL"
    add_index :users, :confirmed_at, name: "index_users_on_confirmed", where: "deleted_at IS NULL"

    add_index :users, :deleted_at, name: "index_users_on_deleted_at", where: "deleted_at IS NOT NULL"
    add_index :users, :deleted_at, name: "index_users_on_deleted_at_null", where: "deleted_at IS NULL"
  end
end
