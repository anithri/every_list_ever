class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email_address, null: false, index: { unique: true }
      t.string :name, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.boolean :visible, default: false
      t.integer :membership, default: 0

      t.timestamps
    end
  end
end
