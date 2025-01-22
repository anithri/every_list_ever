require 'rails_helper'

RSpec.describe OrganizationPolicy, type: :policy, focus: true do
  subject { described_class }

  describe "OrganizationPolicy::Scope" do
    let(:admin) { create :admin_user }
    let(:guest) { create :guest_user }
    let(:member) { create :member_user }
    let(:invisible_org) { create :organization, :visible, :member }
    let(:visible_org) { create :organization, :visible, :member }
    let(:admin_visible_org) { create :organization, :visible, owner: admin }
    let(:admin_invisible_org) { create :organization, :invisible, owner: admin }
    let(:member_invisible_org) { create(:organization, :invisible, owner: member) }
    let(:member_visible_org) { create(:organization, :visible, owner: member) }
    describe "Check data" do
      it "admin, member, guest should be a User and persisted" do
        expect(admin).to be_an_instance_of User
        expect(admin).to be_persisted
        expect(guest).to be_an_instance_of User
        expect(guest).to be_persisted
        expect(member).to be_an_instance_of User
        expect(member).to be_persisted
      end
      it "should have 2 orgs owned by admin" do
        expect(admin_visible_org).to be_an_instance_of Organization
        expect(admin_visible_org).to be_persisted
        expect(admin_visible_org.owner).to eq(admin)

        expect(admin_invisible_org).to be_an_instance_of Organization
        expect(admin_invisible_org).to be_persisted
        expect(admin_invisible_org.owner).to eq(admin)
      end
      it "should have 2 orgs owned by member" do
        expect(member_visible_org).to be_an_instance_of Organization
        expect(member_visible_org).to be_persisted
        expect(member_visible_org.owner).to eq(member)

        expect(member_invisible_org).to be_an_instance_of Organization
        expect(member_invisible_org).to be_persisted
        expect(member_invisible_org.owner).to eq(member)
      end
    end
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

