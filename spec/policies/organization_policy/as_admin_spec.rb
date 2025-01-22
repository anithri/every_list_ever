require 'rails_helper'

RSpec.describe OrganizationPolicy, type: :policy, focus: true do
  subject { described_class }
  describe "as_admin" do
    let(:admin) { create :admin_user }
    let(:guest) { create :guest_user }
    let(:member) { create :member_user }
    let(:invis_org) { create :organization, :visible, :member }
    let(:org) { create :organization, :visible, :member }
    let(:incomplete_org) { build :organization }
    let(:admin_org) { create :organization, owner: admin }
    let(:member_invis_org) { create(:organization, :invisible, owner: member) }
    let(:member_org) { create(:organization, :visible, owner: member) }

    permissions :index? do
      it 'should allow admin users in all cases' do
        expect(subject).to permit(admin, subject)
      end
    end
    permissions :show? do

      it 'it allows admins show any' do
        expect(subject).to permit(admin, invis_org)
        expect(subject).to permit(admin, org)
        expect(subject).to permit(admin, admin_org)
        expect(subject).to permit(admin, member_invis_org)
        expect(subject).to permit(admin, member_org)
      end
    end

    permissions :create? do
      it 'should allow admin to create another' do
        expect(subject).to permit(admin, incomplete_org)
      end
    end

    permissions :update? do
      it 'should allow all' do
        expect(subject).to permit(admin, org)
        expect(subject).to permit(admin, invis_org)
        expect(subject).to permit(admin, admin_org)
        expect(subject).to permit(admin, member_invis_org)
        expect(subject).to permit(admin, member_org)
      end
    end

    permissions :destroy? do
      it 'should denies member when not owner' do
        expect(subject).to permit(admin, org)
        expect(subject).to permit(admin, invis_org)
        expect(subject).to permit(admin, admin_org)
        expect(subject).to permit(admin, member_invis_org)
        expect(subject).to permit(admin, member_org)
      end
    end
  end
end
