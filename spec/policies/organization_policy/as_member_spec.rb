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

    context "when user is a member" do
      permissions :index? do
        it 'should allow member users in all cases' do
          expect(subject).to permit(member, subject)
        end
      end
      permissions :show? do
        it 'it denies member to show invisible' do
          expect(subject).not_to permit(member, invisible_org)
        end
        it 'it allows members to show visible' do
          expect(subject).to permit(member, visible_org)
        end

        it 'it allows owner to show own in all cases' do
          invisible_org.owner = member
          visible_org.owner = member
          expect(subject).to permit(member, invisible_org)
          expect(subject).to permit(member, visible_org)
        end
      end

      permissions :create? do
        it 'should allow owner to create another' do
          expect(subject).to permit(member, incomplete_org)
        end
      end

      permissions :update? do
        it 'should allow member when owner' do
          visible_org.owner = member
          expect(subject).to permit(member, visible_org)
        end
        it 'should denies member when not owner' do
          expect(subject).not_to permit(member, admin_owned_org)
        end
      end

      permissions :destroy? do
        it 'should denies member when not owner' do
          expect(subject).not_to permit(member, admin_owned_org)
        end
      end
    end
  end
end
