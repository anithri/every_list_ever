FactoryBot.define do
  factory :base_organization, class: "Organization" do
    name { |n| "Organization ##{n}" }
    subtitle { "Wooticus Prime!" }
    description { "We Do Things" }
    visible { false }
    association :owner, factory: :member_user
    trait :visible do
      visible { true }
    end
    trait :invisible do
      visible { false }
    end
    trait :admin do
      association :owner, factory: :admin_user
    end
    trait :guest do
      association :owner, factory: :guest_user
    end
    trait :member do
      association :owner, factory: :member_user
    end

    factory :organization, traits: [ :visible, :member ]
    factory :admin_organization, traits: [ :visible, :admin ]
    factory :guest_organization, traits: [ :visible, :guest ]
    factory :member_organization, traits: [ :visible, :member ]
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
