class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email_address, null: false, index: { unique: true }
      t.string :name, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.boolean :visible, default: false
      t.integer :membership, default: 0
      t.string :location
      t.string :description
      t.string :avatar_url

      t.timestamps
    end
    execute "ALTER TABLE users ADD CONSTRAINT membership_check CHECK (membership IN (0, 1, 2));"
    execute "ALTER SEQUENCE users_id_seq RESTART WITH 100;"
  end
end
