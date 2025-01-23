# frozen_string_literal: true

RoleType::ROLE_DATA.each do |role, level|
  rt = RoleType.find_or_create_by(name: role)
end
