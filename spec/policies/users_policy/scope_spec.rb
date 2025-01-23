require 'rails_helper'

RSpec.describe UserPolicy, type: :policy, focus: true do
  subject { described_class }

  describe "OrganizationPolicy::Scope" do
    let(:admin) { create :user, :visible, :admin }
    let(:guest) { create :user, :guest }
    let(:member) { create :user, :invisible, :member }
    let(:invisible) { create :user, :invisible, :member }
    let(:member2) { create :user, :visible, :member }

    permissions ".scope" do
      let(:users) { [ admin, guest, member, invisible, member2 ] }
      it "should allow admin to return all users" do
        users
        expected_count = User.count
        scope = Pundit.policy_scope(admin, User)
        expect(scope.count).to eq(expected_count)
      end
      it "should allow guest to return no users" do
        users
        scope = Pundit.policy_scope(guest, User)
        expect(scope.count).to eq(0)
      end
      it "should allow member to return all visible plus themselves" do
        users
        expected_count = User.visible.count + User.where(visible: false, id: member.id).count
        scope = Pundit.policy_scope(member, User)
        expect(scope.count).to eq(expected_count)
      end
    end
  end
end

