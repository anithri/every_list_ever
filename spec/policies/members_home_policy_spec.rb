require 'rails_helper'

RSpec.describe MembersHomePolicy, type: :policy do
  let(:admin) { build(:admin_user) }
  let(:guest) { build(:guest_user) }
  let(:member) { build(:member_user) }

  subject { described_class }

  permissions :home? do
    it 'should allow admin users' do
      expect(subject).to permit(admin)
    end
    it 'should deny guest users' do
      expect(subject).not_to permit(guest)
    end
    it 'should allow member users' do
      expect(subject).to permit(member)
    end
  end
end
