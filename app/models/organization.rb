class Organization < ApplicationRecord
  # scopes
  scope :visible, -> { where(visible: true) }

  # Constants
  # accessors
  # enums
  # associations
  belongs_to :owner, class_name: "User"
  has_many :organization_members
  has_many :users, through: :organization_members, class_name: "User"

  has_many :administrators, -> { where(organization_members: { role: :administrator }) }, through: :organization_members, source: :user
  has_many :contributors, -> { where(organization_members: { role: :contributor }) }, through: :organization_members, source: :user
  has_many :editors, -> { where(organization_members: { role: :editor }) }, through: :organization_members, source: :user
  has_many :voters, -> { where(organization_members: { role: :voter }) }, through: :organization_members, source: :user
  has_many :viewers, -> { where(organization_members: { role: :viewer }) }, through: :organization_members, source: :user

  # validations
  # TODO , length: { in: 8..32 } removed for weird spec results
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :owner, presence: true

  # callbacks

end

# == Schema Information
#
# Table name: organizations
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           not null
#  subtitle    :string
#  visible     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :bigint           not null
#
# Indexes
#
#  index_organizations_on_name      (name) UNIQUE
#  index_organizations_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
