require 'rails_helper'

RSpec.describe OrganizationPolicy, type: :policy, focus: true do
  subject { described_class }
  describe "user action permissions" do
    let(:admin) { create :admin_user }
    let(:guest) { create :guest_user }
    let(:member) { create :member_user }
    let(:invisible_org) { create :organization, visible: false }
    let(:visible_org) { create :organization, visible: true }
    let(:admin_owned_org) { create :organization, owner: admin }
    let(:incomplete_org) { build :organization }
    let(:owned_invisible_org) { create(:organization, :invisible, owner: member) }
    let(:owned_visible_org) { create(:organization, :visible, owner: member) }

    context "when user is a admin" do
      permissions :index? do
        it 'should allow admin users in all cases' do
          expect(subject).to permit(admin, subject)
        end
      end
      permissions :show? do

        it 'it allows admins show any' do
          expect(subject).to permit(admin, visible_org)
          expect(subject).to permit(admin, invisible_org)
          expect(subject).to permit(admin, admin_owned_org)
          expect(subject).to permit(admin, owned_invisible_org)
          expect(subject).to permit(admin, owned_visible_org)
        end
      end

      permissions :create? do
        it 'should allow admin to create another' do
          expect(subject).to permit(admin, incomplete_org)
        end
      end

      permissions :update? do
        it 'should allow all' do
          expect(subject).to permit(admin, visible_org)
          expect(subject).to permit(admin, invisible_org)
          expect(subject).to permit(admin, admin_owned_org)
          expect(subject).to permit(admin, owned_invisible_org)
          expect(subject).to permit(admin, owned_visible_org)
        end
      end

      permissions :destroy? do
        it 'should denies member when not owner' do
          expect(subject).to permit(admin, visible_org)
          expect(subject).to permit(admin, invisible_org)
          expect(subject).to permit(admin, admin_owned_org)
          expect(subject).to permit(admin, owned_invisible_org)
          expect(subject).to permit(admin, owned_visible_org)
        end
      end
    end
  end
end
