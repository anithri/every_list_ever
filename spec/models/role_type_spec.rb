require 'rails_helper'

RSpec.describe RoleType, type: :model do
  let(:administrator_role) { create :administrator_role }
  let(:editor_role) { create :editor_role }
  let(:contributor_role) { create :contributor_role }
  let(:voter_role) { create :voter_role }
  let(:member_role) { create :member_role }
  let(:role_types) { [ administrator_role, editor_role, contributor_role, voter_role, member_role ].shuffle }

  describe "validations" do
    it "should check uniqueness of name" do
      second = build :voter_role
      second.id = nil
      second.save
      expect(second.errors.messages[:name]).to include "has already been taken"

    end
  end

  describe "scopes" do
    it "should return all roles in order" do
      db = RoleType.sorted.to_a
      roles = role_types.sort_by(&:order)
      expect(db).to eq roles
    end
  end
end

# == Schema Information
#
# Table name: role_types
#
#  id    :bigint           not null, primary key
#  name  :string           not null
#  order :integer          default(0), not null
#
# Indexes
#
#  index_role_types_on_name  (name) UNIQUE
#
