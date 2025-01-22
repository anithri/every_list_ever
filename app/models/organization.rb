class Organization < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  # TODO , length: { in: 8..32 } removed for weird spect results
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :owner, presence: true

  scope :visible, -> { where(visible: true) }
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
