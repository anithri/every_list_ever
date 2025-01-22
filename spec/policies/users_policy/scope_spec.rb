require 'rails_helper'

RSpec.describe UserPolicy, type: :policy, focus: true do
  subject { described_class }

  describe "OrganizationPolicy::Scope" do
    let(:admin) { create :user, :admin }
    let(:guest) { create :user, :guest }
    let(:member) { create :user, :member }

    permissions ".scope" do
      it "should allow admin to return all users" do
        expected_count = User.count
        resolved = subject::Scope.new(admin, User).resolve
        expect(resolved.count).to eq(expected_count)
      end
      it "should allow guest to return no organizations" do
        resolved = subject::Scope.new(guest, User).resolve
        expect(resolved.count).to eq(0)
      end
      it "should allow member to return all visible plus themselves" do
        expected_count = User.visible.count + User.where(visible: false, id: member.id).count
        resolved = subject::Scope.new(member, User).resolve
        expect(resolved.count).to eq(expected_count)
      end
    end
  end
end

