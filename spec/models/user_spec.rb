require 'rails_helper'

RSpec.describe User, type: :model do
    let(:invisible_user) { build(:user, :invisible, :member) }
    let(:visible_user) { build(:user, :visible, :member) }

  describe 'class features & validations' do
    subject { build(:member_user) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    # it { is_expected.to validate_uniqueness_of(:name) }
    # it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_length_of(:name) }
    it { is_expected.to normalize(:email).from('BOB@example.com').to('bob@example.com') }
    it { is_expected.to define_enum_for(:site_role).with_values([ :guest, :member, :admin ]).with_default(:guest) }
    it { is_expected.to have_many(:organization_members) }
    it { is_expected.to have_many(:administrator_orgs) }
    it { is_expected.to have_many(:contributor_orgs) }
    it { is_expected.to have_many(:editor_orgs) }
    it { is_expected.to have_many(:voter_orgs) }
    it { is_expected.to have_many(:viewer_orgs) }

  end

  describe 'class methods' do
    describe '.guest' do
      let(:guest_user) { create(:guest_user) }
      subject { guest_user; User.guest }

      it { is_expected.to be_a(User) }
      it 'should return a guest user' do
        expect(subject.guest?).to be true
      end
    end
  end

  describe 'instance methods' do
    describe '#invisible?' do
      it "should return true if user.visible is false" do
        expect(invisible_user).to be_invisible
      end
      it "should return false if user.visible is true" do
        expect(visible_user).not_to be_invisible
      end
    end
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
