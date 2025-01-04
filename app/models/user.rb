# == Schema Information
# Schema version: 20241124002558
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email_address   :string           not null, indexed
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#

class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  alias_method :guest?, :new_record?
end
