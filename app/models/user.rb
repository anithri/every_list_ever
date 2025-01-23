class User < ApplicationRecord
  include Clearance::User
  enum :site_role, [ :guest, :member, :admin ], default: :guest

  has_many :organizations, dependent: :destroy
  accepts_nested_attributes_for :organizations, allow_destroy: true

  normalizes :email, with: ->(e) { e.strip.downcase }

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
            presence: true, uniqueness: { case_sensitive: false }
  validates :settings, presence: true
  validates :site_role, presence: true, inclusion: { in: site_roles.keys }

  scope :visible, -> { where(visible: true) }
  scope :active, -> { where(deleted_at: nil) }
  scope :confirmed, -> { where.not(confirmed_at: nil) }

  def self.guest
    @@_guest ||= User.find_by(site_role: :guest)
  end

  def invisible?
    ! visible?
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
