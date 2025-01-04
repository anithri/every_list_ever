# == Schema Information
# Schema version: 20241124002558
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null, indexed
#  ip_address :string
#  user_agent :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sessions_on_user_id  (user_id)
#

class Session < ApplicationRecord
  belongs_to :user
end
