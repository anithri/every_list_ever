class User < ApplicationRecord
  has_secure_password
  enum :site_role, [ :guest, :registered, :admin ], default: :guest

  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP },
            presence: true, uniqueness: { case_sensitive: false }
  # name will need additional validation for naughty words
  validates :name, presence: true, uniqueness: true, length: { in: 3..20 }


  scope :authenticated, -> { where("id >= 100", 200).where(site_role: :registered) }
  def self.guest
    @guest_user ||= find_by(email_address: "guest@abc.123.example.dev").freeze
  end

end

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  avatar_url      :string
#  description     :string
#  email_address   :string           not null
#  location        :string
#  name            :string           not null
#  password_digest :string           not null
#  site_role       :integer          default("guest")
#  visible         :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#  index_users_on_name           (name) UNIQUE
#
