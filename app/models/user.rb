class User < ApplicationRecord
  # scopes
  scope :visible, -> { where(visible: true) }
  scope :active, -> { where(deleted_at: nil) }
  scope :confirmed, -> { where.not(confirmed_at: nil) }

  # constants

  # accessors

  # enum
  enum :site_role, [ :guest, :unconfirmed, :member, :admin ], default: :guest

  # associations
  has_many :organizations, class_name: "Organization", foreign_key: :owner_id, dependent: :destroy
  has_many :organization_members, dependent: :destroy
  has_many :administrator_orgs, -> { where(organization_members: { role: :administrator }) }, through: :organization_members, source: :organization
  has_many :contributor_orgs, -> { where(organization_members: { role: :contributor }) }, through: :organization_members, source: :organization
  has_many :editor_orgs, -> { where(organization_members: { role: :editor }) }, through: :organization_members, source: :organization
  has_many :voter_orgs, -> { where(organization_members: { role: :voter }) }, through: :organization_members, source: :organization
  has_many :viewer_orgs, -> { where(organization_members: { role: :viewer }) }, through: :organization_members, source: :organization

  accepts_nested_attributes_for :organizations, allow_destroy: true
  # validations
  normalizes :email, with: ->(e) { e.strip.downcase }
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
            presence: true, uniqueness: { case_sensitive: false }
  validates :settings, presence: true
  validates :site_role, presence: true, inclusion: { in: site_roles.keys }
  validates_confirmation_of :password, if: :password_required?

  # callbacks

  # other macros
  include Clearance::User

  # instance methods
  def invisible?
    !visible?
  end

  def password_required?
    return true if new_record?
    password.present? || password_confirmation.present?
  end

  # class methods

  def self.guest
    @@_guest ||= User.find_by(site_role: :guest)
  end
end

# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  avatar_url         :string
#  confirmation_token :string(128)
#  confirmed_at       :datetime
#  deleted_at         :datetime
#  description        :text
#  email              :string           not null
#  encrypted_password :string(128)      not null
#  location           :string
#  name               :string           not null
#  remember_token     :string(128)      not null
#  settings           :json             not null
#  site_role          :integer          default("guest"), not null
#  visible            :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token  (confirmation_token) UNIQUE
#  index_users_on_confirmed           (confirmed_at) WHERE (deleted_at IS NULL)
#  index_users_on_confirmed_at_null   (confirmed_at) WHERE (deleted_at IS NULL)
#  index_users_on_deleted_at          (deleted_at) WHERE (deleted_at IS NOT NULL)
#  index_users_on_deleted_at_null     (deleted_at) WHERE (deleted_at IS NULL)
#  index_users_on_email               (email) UNIQUE
#  index_users_on_name                (name) UNIQUE
#  index_users_on_remember_token      (remember_token) UNIQUE
#  index_users_on_site_role           (site_role)
#  index_users_on_visible             (visible)
#
