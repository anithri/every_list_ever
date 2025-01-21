class Organization < ApplicationRecord
  belongs_to :owner, foreign_key: :user_id, class_name: "User"
  has_many :lists, dependent: :destroy
  validates :name, presence: true, uniqueness: true
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

