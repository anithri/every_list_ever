require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:member_user) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email_address) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_uniqueness_of(:email_address) }
    it { is_expected.to validate_length_of(:name) }
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
