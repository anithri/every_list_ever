FactoryBot.define do
  factory :organization, class: "Organization" do
    name { |n| "Organization ##{n}" }
    subtitle { "Wooticus Prime!" }
    description { "We Do Things" }
    visible { false }

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

    factory :admin_org, traits: [ :visible, :admin ]
    factory :member_org, traits: [ :visible, :member ], aliases: [ :org]
    factory :incomplete_org
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
