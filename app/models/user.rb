class User < ApplicationRecord
  has_secure_password
  enum :membership, [ :guest, :member, :admin ], default: :guest

  has_many :sessions, dependent: :destroy
  has_one :profile, dependent: :destroy

  accepts_nested_attributes_for :profile
  normalizes :email_address, with: ->(e) { e.strip.downcase }

end

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email_address   :string           not null
#  membership      :integer          default("guest")
#  name            :string           not null
#  password_digest :string           not null
#  visible         :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#  index_users_on_name           (name) UNIQUE
#
