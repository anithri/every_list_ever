require 'rails_helper'

RSpec.describe OrganizationPolicy, type: :policy, focus: true do
  let(:admin) { User.new(id: 10, membership: :admin) }
  let(:guest) { User.new(id: 20, membership: :guest) }
  let(:member) { User.new(id: 30, membership: :member) }
  let(:invisible_org) { Organization.new(user_id: member.id) }
  let(:visible_org) { Organization.new(user_id: member.id, visible: true) }
  let(:admin_owned_org) { Organization.new(user_id: admin.id) }
  let(:incomplete_org) { Organization.new }

  subject { described_class }

  describe "OrganizationPolicy::Scope" do
    permissions ".scope" do

    end
  end

  describe "user action permissions" do
    permissions :index? do
      it 'should allow admin users in all cases' do
        expect(subject).to permit(admin, Organization)
      end
      it 'should deny guest users in all cases' do
        expect(subject).to permit(guest, Organization)
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
      it 'it allows guest to show visible' do
        expect(subject).to permit(guest, visible_org)
      end

      it 'it denies member to show invisible' do
        expect(subject).not_to permit(guest, invisible_org)
      end
      it 'it allows members to show visible' do
        expect(subject).to permit(member, visible_org)
      end

      it 'it allows owner to show own in all cases' do
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
        expect(subject).to permit(member, visible_org)
      end
      it 'should denies member when not owner' do
        expect(subject).not_to permit(member, admin_owned_org)
      end
    end
  end
  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end