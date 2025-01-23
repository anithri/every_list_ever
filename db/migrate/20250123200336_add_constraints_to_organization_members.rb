class AddConstraintsToOrganizationMembers < ActiveRecord::Migration[8.0]
  def up
    execute "ALTER TABLE organization_members ADD CONSTRAINT role_values_check CHECK (role IN (10,20,30,40,90));"
  end
  def down
    execute "ALTER TABLE organization_members DROP CONSTRAINT role_values_check;"
  end
end

