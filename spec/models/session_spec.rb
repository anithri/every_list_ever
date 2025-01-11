require 'rails_helper'

RSpec.describe Session, type: :model do
  describe 'class features & validations' do
    subject { build(:member_session) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to belong_to(:user) }
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
