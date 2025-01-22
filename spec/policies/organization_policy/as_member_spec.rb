require 'rails_helper'

RSpec.describe OrganizationPolicy, type: :policy, focus: true do
  subject { described_class }
  describe "user action permissions" do
    let(:admin) { create :admin_user }
    let(:guest) { create :guest_user }
    let(:member) { create :member_user }
    let(:member2) { create :member_user }

    let(:invis_org) { create :organization, :invisible, owner: member2 }
    let(:org) { create :organization, :visible, owner: member2 }
    let(:admin_org) { create :organization, owner: admin }
    let(:incomplete_org) { build :organization, :visible }
    let(:member_invis_org) { create(:organization, :invisible, owner: member) }
    let(:member_org) { create(:organization, owner: member) }

    context "when user is a member" do
      permissions :index? do
        it 'should allow member users in all cases' do
          expect(subject).to permit(member, subject)
        end
      end
      permissions :show? do
        it 'it denies member to show invisible' do
          expect(subject).not_to permit(member, invis_org)
        end
        it 'it allows members to show visible' do
          expect(subject).to permit(member, org)
        end

        it 'it allows owner to show own in all cases' do
          expect(subject).to permit(member, member_invis_org)
          expect(subject).to permit(member, member_org)
        end
      end

      permissions :create? do
        it 'should allow owner to create another' do
          expect(subject).to permit(member, incomplete_org)
        end
      end

      permissions :update? do
        it 'should allow member when owner' do
          expect(subject).to permit(member, member_org)
          expect(subject).to permit(member, member_invis_org)
        end
        it 'should denies member when not owner' do
          expect(subject).not_to permit(member, org)
          expect(subject).not_to permit(member, admin_org)
        end
      end

      permissions :destroy? do
        it 'should denies member when not owner' do
          expect(subject).not_to permit(member, admin_org)
          expect(subject).not_to permit(member, invis_org)
          expect(subject).not_to permit(member, org)
        end
      end
    end
  end
end
