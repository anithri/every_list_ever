FactoryBot.define do
  factory :organization do
    name { "MyString" }
    subtitle { "MyString" }
    description { "MyText" }
    association :user, factory: :member_user
    visible { false }
  end
end

# == Schema Information
#
# Table name: organizations
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           not null
#  subtitle    :string
#  visible     :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_organizations_on_name     (name) UNIQUE
#  index_organizations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
