require 'rails_helper'
RSpec.describe Organization, type: :model do
  describe "class features & validations" do
    subject { build(:organization) }

    # Validations
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:owner) }
    #
    # it { should validate_length_of(:name).is_at_least(8) }
    it { should validate_uniqueness_of(:name).case_insensitive }

    # associations
    it { should belong_to(:owner).class_name('User') }

    # Scopes
    describe ".visible" do
      let!(:visible_organization) { create(:organization, :visible) }
      let!(:invisible_organization) { create(:organization, :invisible) }

      it "returns only visible organizations" do
        expect(Organization.visible).to include(visible_organization)
        expect(Organization.visible).not_to include(invisible_organization)
      end
    end
  end
end

# == Schema Information
#
# Table name: organizations
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           not null
#  subtitle    :string
#  visible     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :bigint           not null
#
# Indexes
#
#  index_organizations_on_name      (name) UNIQUE
#  index_organizations_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
