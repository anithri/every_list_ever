FactoryBot.define do
  factory :role_type do
    name { "MyString" }
    order { 100 }
    RoleType::ROLE_DATA.each do |(role, order)|
      factory "#{role}_role".to_sym do
        order { order }
        name { role }
      end
    end
  end
end

# == Schema Information
#
# Table name: role_types
#
#  id    :bigint           not null, primary key
#  name  :string           not null
#  order :integer          default(0), not null
#
# Indexes
#
#  index_role_types_on_name  (name) UNIQUE
#
