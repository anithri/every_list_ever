FactoryBot.define do
  factory :organization_member do
    organization { }
    user { nil }
    role { 'viewer' }
  end
end

# == Schema Information
#
# Table name: organization_members
#
#  id              :bigint           not null, primary key
#  role            :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_organization_members_on_organization_id              (organization_id)
#  index_organization_members_on_organization_id_and_user_id  (organization_id,user_id) UNIQUE
#  index_organization_members_on_user_id                      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (user_id => users.id)
#
