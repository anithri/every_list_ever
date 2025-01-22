require 'rails_helper'

RSpec.describe UserPolicy, type: :policy, focus: true do
  subject { described_class }

  describe "OrganizationPolicy::Scope" do
    let(:admin) { create :admin_user }
    let(:guest) { create :guest_user }
    let(:member) { create :member_user }
    describe "Check data" do
      it "admin, member, guest should be a User and persisted" do
        expect(admin).to be_an_instance_of User
        expect(admin).to be_persisted
        expect(guest).to be_an_instance_of User
        expect(guest).to be_persisted
        expect(member).to be_an_instance_of User
        expect(member).to be_persisted
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

