class OrganizationMember < ApplicationRecord
  # scopes
  scope :administrators, -> { where(role: :administrator) }
  scope :contributors, -> { where(role: :contributor) }
  scope :editors, -> { where(role: :editor) }
  scope :voters, -> { where(role: :voter) }
  scope :viewers, -> { where(role: :viewer) }
  # accessors
  # enum
  enum :role, { administrator: 10, editor: 20, contributor: 30, voter: 40, viewer: 90 }, default: :viewer
  # associations
  belongs_to :organization
  belongs_to :user
  # validations
  validates :organization, :user, presence: true
  validates :user, uniqueness: { scope: :organization }
  # callbacks
  # other macros

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
