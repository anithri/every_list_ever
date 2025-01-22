# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  after(:each) do
    User.delete_all
  end
  let(:admin) { create(:admin_user) }
  let(:guest) { create(:guest_user) }
  let(:member) { create(:member_user) }
  let(:invisible) { create(:member_user, :invisible) }
  let(:visible) { create(:member_user, :visible) }

  subject { described_class }

  describe "UserPolicy::Scope" do
    before(:each) { [ admin, guest, member, invisible, visible ] }
    permissions :scope do
      it 'should allow admin users to return all users' do
        expected_count = User.count
        resolved = subject::Scope.new(admin, User).resolve
        expect(resolved.count).to eq(expected_count)
      end
      it 'should allow guest users to return no users' do
        expected_count = 0
        resolved = subject::Scope.new(guest, User).resolve
        expect(resolved.count).to eq(expected_count)
      end
      it 'should allow member users to return all visible plus themselves' do
        expected_count = User.visible.count + (member.visible? ? 0 : 1)
        resolved = subject::Scope.new(member, User).resolve
        expect(resolved.count).to eq(expected_count)
      end
    end
  end
end
