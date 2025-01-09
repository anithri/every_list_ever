require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'class features & validations' do
    subject { build(:member_user) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email_address) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_uniqueness_of(:email_address).case_insensitive }
    it { is_expected.to validate_length_of(:name) }
    it { is_expected.to have_secure_password }
    it { is_expected.to normalize(:email_address).from('BOB@example.com').to('bob@example.com')}
    it { is_expected.to define_enum_for(:membership).with_values([:guest, :member, :admin]).with_default(:guest) }
    it { is_expected.to have_many(:sessions).dependent(:destroy) }
  end

  describe 'class methods' do
    describe '.guest' do
      let (:guest_user) { create(:guest_user) }
      subject { guest_user; User.guest }
    end
    it { is_expected.to be_a(User) }
    it 'should return a guest user' do
      expect(subject.guest?).to be true
    end
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
