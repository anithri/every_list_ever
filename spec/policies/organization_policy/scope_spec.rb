require 'rails_helper'

RSpec.describe OrganizationPolicy, type: :policy, focus: true do
  subject { described_class }

  describe "OrganizationPolicy::Scope" do
    let(:admin) { create :admin_user }
    let(:guest) { create :guest_user }
    let(:member) { create :member_user }
    let(:invis_org) { create :organization, :member }
    let(:visible_org) { create :organization, :member }
    let(:admin_visible_org) { create :organization, owner: admin }
    let(:admin_invisible_org) { create :organization, :invisible, owner: admin }
    let(:member_invisible_org) { create(:organization, :invisible, owner: member) }
    let(:member_visible_org) { create(:organization, owner: member) }

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
        expected_count = Organization.visible.count + Organization.where(owner: member).count
        resolved = subject::Scope.new(member, Organization).resolve
        expect(resolved.count).to eq(expected_count)
      end
    end
  end
end

