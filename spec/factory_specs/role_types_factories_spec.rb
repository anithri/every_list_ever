require "rails_helper"

all_factories = %w[administrator editor contributor voter member].map { |n| "#{n}_role".to_sym }

RSpec.describe "Role Types Factories", type: :factory do
  let(:administrator_role) { create :administrator_role }
  let(:editor_role) { create :editor_role }
  let(:contributor_role) { create :contributor_role }
  let(:voter_role) { create :voter_role }
  let(:member_role) { create :member_role }
  let(:all_roles) { [ administrator_role, editor_role, contributor_role, voter_role, member_role ].shuffle.sort_by(&:order) }

  describe "scopes" do
    context "sorted" do
      it "returns all roles in order" do
        all_roles
        all = RoleType.ordered.to_a
        expect(all).to eq all_roles
      end
    end
  end

  it "should create all roles" do
    expect(all_roles.size).to eq all_factories.size
  end
end
