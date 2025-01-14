require 'rails_helper'

RSpec.describe OrganizationPolicy, type: :policy, focus: true do
  let(:admin) { User.new(id: 10, site_role: :admin) }
  let(:guest) { User.new(id: 20, site_role: :guest) }
  let(:registered_user) { User.new(id: 30, site_role: :registered_user) }
  let(:invisible_org) { Organization.new(user_id: registered_user.id) }
  let(:visible_org) { Organization.new(user_id: registered_user.id, visible: true) }
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
      it 'should allow registered_user users in all cases' do
        expect(subject).to permit(registered_user, Organization)
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

      it 'it denies registered_user to show invisible' do
        expect(subject).not_to permit(guest, invisible_org)
      end
      it 'it allows registered_users to show visible' do
        expect(subject).to permit(registered_user, visible_org)
      end

      it 'it allows owner to show own in all cases' do
        expect(subject).to permit(registered_user, invisible_org)
        expect(subject).to permit(registered_user, visible_org)
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
        expect(subject).to permit(registered_user, incomplete_org)
      end
    end

    permissions :update? do
      it 'should allow admin users in all cases' do
        expect(subject).to permit(admin, visible_org)
      end
      it 'should deny guest users in all cases' do
        expect(subject).not_to permit(guest, visible_org)
      end
      it 'should allow registered_user when owner' do
        expect(subject).to permit(registered_user, visible_org)
      end
      it 'should denies registered_user when not owner' do
        expect(subject).not_to permit(registered_user, admin_owned_org)
      end
    end

    permissions :destroy? do
      it 'should allow admin users in all cases' do
        expect(subject).to permit(admin, visible_org)
      end
      it 'should deny guest users in all cases' do
        expect(subject).not_to permit(guest, visible_org)
      end
      it 'should allow registered_user when owner' do
        expect(subject).to permit(registered_user, visible_org)
      end
      it 'should denies registered_user when not owner' do
        expect(subject).not_to permit(registered_user, admin_owned_org)
      end
    end
  end
  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end