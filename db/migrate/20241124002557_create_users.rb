class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email_address, null: false, index: { unique: true }
      t.string :name, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.boolean :visible, default: false
      t.integer :site_role, default: 0
      t.string :location
      t.string :description
      t.string :avatar_url

      t.timestamps
    end

    execute "ALTER TABLE users ADD CONSTRAINT site_role_check CHECK (site_role IN (0, 1, 2));"

  end
end
