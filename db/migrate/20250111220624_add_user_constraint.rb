class AddUserConstraint < ActiveRecord::Migration[8.0]
  def up
    execute "ALTER TABLE users ADD CONSTRAINT membership_check CHECK (membership IN (0, 1, 2));"
  end
end
