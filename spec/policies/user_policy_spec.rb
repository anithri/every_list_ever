# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class }

  describe "UserPolicy::Scope" do
    let(:admin) { create(:admin_user) }
    let(:guest) { create(:guest_user) }
    let(:member) { create(:member_user) }
    let(:invisible) { create(:member_user, :invisible) }
    let(:visible) { create(:member_user, :visible) }
    before(:each) { [ admin, guest, member, invisible, visible ] }

  it 'should allow admin users to return all users' do
    expected_count = User.count
    resolved = subject::Scope.new(admin, User).resolve
    resolved_count = resolved.count
    expect(resolved_count).to be(expected_count)
  end
  it 'should allow guest users to return no users' do
    expected_count = 0
    resolved = subject::Scope.new(guest, User).resolve
    resolved_count = resolved.count
    expect(resolved_count).to be(expected_count)
  end
  it 'should allow member users to return all visible plus themselves' do
    expected_count = User.visible.count + (member.visible? ? 0 : 1)
    resolved = subject::Scope.new(member, User).resolve
    expect(resolved.count).to be(expected_count)
  end
end
end
