require 'rails_helper'

RSpec.describe OrganizationPolicy, type: :policy, focus: true do
  subject { described_class }
  describe "user action permissions" do
    let(:admin) { create :admin_user }
    let(:guest) { create :guest_user }
    let(:member) { create :member_user }
    let(:invis_org) { create :organization, visible: false }
    let(:visible_org) { create :organization, visible: true }
    let(:admin_owned_org) { create :organization, owner: admin }
    let(:incomplete_org) { build :organization }
    let(:owned_invisible_org) { create(:organization, :invisible, owner: member) }
    let(:owned_visible_org) { create(:organization, :visible, owner: member) }

    context "when user is a guest" do
      permissions :index? do
        it 'allow guests' do
          expect(subject).to permit(admin, subject)
        end
      end

      permissions :show? do
        it 'it allows admins show any' do
          expect(subject).not_to permit(guest, visible_org)
          expect(subject).not_to permit(guest, invis_org)
          expect(subject).not_to permit(guest, admin_owned_org)
          expect(subject).not_to permit(guest, owned_invisible_org)
          expect(subject).not_to permit(guest, owned_visible_org)
        end
      end

      permissions :create? do
        it 'should deny guest' do
          expect(subject).not_to permit(guest, incomplete_org)
        end
      end

      permissions :update? do
        it 'should deny all' do
          expect(subject).not_to permit(guest, visible_org)
          expect(subject).not_to permit(guest, invis_org)
          expect(subject).not_to permit(guest, admin_owned_org)
          expect(subject).not_to permit(guest, owned_invisible_org)
          expect(subject).not_to permit(guest, owned_visible_org)
        end
      end

      permissions :destroy? do
        it 'should denies member when not owner' do
          expect(subject).not_to permit(guest, visible_org)
          expect(subject).not_to permit(guest, invis_org)
          expect(subject).not_to permit(guest, admin_owned_org)
          expect(subject).not_to permit(guest, owned_invisible_org)
          expect(subject).not_to permit(guest, owned_visible_org)
        end
      end
    end
  end
end
