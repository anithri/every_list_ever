FactoryBot.define do
  factory :admin_session, class: "Session" do
    user { build :admin_user }
  end
  factory :guest_session, class: "Session" do
    user { build :guest_user }
  end
  factory :member_session, class: "Session" do
    user { build :member_user }
  end
end

# == Schema Information
#
# Table name: sessions
#
#  id         :bigint           not null, primary key
#  ip_address :string
#  user_agent :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_sessions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
