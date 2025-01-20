require 'rails_helper'

RSpec.describe OrganizationPolicy, type: :policy, focus: true do
  let(:admin) { create :admin_user }
  let(:guest) { create :guest_user }
  let(:member) { create :member_user }
  let(:invisible_org) { build :organization, visible: false }
  let(:visible_org) { build :organization, visible: true }
  let(:admin_owned_org) { build :organization, user: admin }
  let(:incomplete_org) { build :organization }

  subject { described_class }

  describe "OrganizationPolicy::Scope" do
    let(:invisible_org) { create :organization, visible: false }
    let(:visible_org) { create :organization, visible: true }
    let(:admin_owned_org) { create :organization, user: admin }
    let(:incomplete_org) { create :organization }
    let(:owned_invisible_org) { create(:organization, user: member, visible: false) }
    permissions ".scope" do
      it "should allow admin to return all organizations" do
        expected_count = Organization.count
        resolved = subject::Scope.new(admin, Organization).resolve
        expect(resolved.count).to eq(expected_count)
      end
      it "should allow guest to return no organizations" do
        expected_count = 0
        resolved = subject::Scope.new(guest, Organization).resolve
        expect(resolved.count).to eq(expected_count)
      end
      it "should allow member to return all visible plus themselves" do
        expected_count = Organization.visible.count + Organization.where(user: member).count
        resolved = subject::Scope.new(member, Organization).resolve
        expect(resolved.count).to eq(expected_count)
      end
    end
  end

  describe "user action permissions" do
    permissions :index? do
      it 'should allow admin users in all cases' do
        expect(subject).to permit(admin, Organization)
      end
      it 'should deny guest users in all cases' do
        expect(subject).not_to permit(guest, Organization)
      end
      it 'should allow member users in all cases' do
        expect(subject).to permit(member, Organization)
      end
    end
    permissions :show? do
      it 'it allows admin users in all cases' do
        expect(subject).to permit(admin, invisible_org)
        expect(subject).to permit(admin, visible_org)
      end

      it 'it denies guest to show invisible' do
        expect(subject).not_to permit(guest, invisible_org)
      end
      it 'it denies guest to show visible' do
        expect(subject).not_to permit(guest, visible_org)
      end

      it 'it denies member to show invisible' do
        expect(subject).not_to permit(guest, invisible_org)
      end
      it 'it allows members to show visible' do
        expect(subject).to permit(member, visible_org)
      end

      it 'it allows owner to show own in all cases' do
        invisible_org.user = member
        visible_org.user = member
        expect(subject).to permit(member, invisible_org)
        expect(subject).to permit(member, visible_org)
      end
    end

    permissions :create? do
      it 'should allow admin users in all cases' do
        expect(subject).to permit(admin, incomplete_org)
      end
      it 'should deny guest users in all cases' do
        expect(subject).not_to permit(guest, incomplete_org)
      end
      it 'should allow owner to create another' do
        expect(subject).to permit(member, incomplete_org)
      end
    end

    permissions :update? do
      it 'should allow admin users in all cases' do
        expect(subject).to permit(admin, visible_org)
      end
      it 'should deny guest users in all cases' do
        expect(subject).not_to permit(guest, visible_org)
      end
      it 'should allow member when owner' do
        visible_org.user = member
        expect(subject).to permit(member, visible_org)
      end
      it 'should denies member when not owner' do
        expect(subject).not_to permit(member, admin_owned_org)
      end
    end

    permissions :destroy? do
      it 'should allow admin users in all cases' do
        expect(subject).to permit(admin, visible_org)
      end
      it 'should deny guest users in all cases' do
        expect(subject).not_to permit(guest, visible_org)
      end
      it 'should allow member when owner' do
        visible_org.user = member
        expect(subject).to permit(member, visible_org)
      end
      it 'should denies member when not owner' do
        expect(subject).not_to permit(member, admin_owned_org)
      end
    end
  end
end