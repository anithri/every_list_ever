require 'rails_helper'

RSpec.describe OrganizationPolicy::Scope, type: :policy, focus: true do
  subject { described_class }

  let(:admin) { create :admin_user }
  let(:guest) { create :guest_user }
  let(:member) { create :member_user }
  let(:member2) { create :member_user }
  let(:invis_org) { create :organization, :invisible, owner: member2 }
  let(:org) { create :organization, :visible, owner: member2 }
  let(:admin_invis_org) { create :organization, :invisible, owner: admin }
  let(:admin_org) { create :organization, :visible, owner: admin }
  let(:member_invis_org) { create(:organization, :invisible, owner: member) }
  let(:member_org) { create(:organization, :visible, owner: member) }
  let(:orgs) { [ invis_org, org, admin_invis_org, admin_invis_org, member_invis_org, member_org ] }

  it "should allow admin to return all" do
    orgs
    scope = described_class.new(admin, Organization).resolve
    expected_count = Organization.count
    expect(scope.count).to eq(expected_count)
  end
  it "should allow guest to return no organizations" do
    orgs
    scope = described_class.new(guest, Organization).resolve
    expected_count = 0
    expect(scope.count).to eq(expected_count)
  end
  it "should allow member to return all visible plus themselves" do
    orgs

    scope = described_class.new(member, Organization).resolve
    final = orgs.select { |o| o.visible? || o.owner == member }.length
    expected_count = Organization.visible.count + Organization.where(owner: member).count
    expect(scope.count).to eq(final)
  end
end

