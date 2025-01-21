FactoryBot.define do
  factory :base_organization, class: "User" do
    sequence(:name) { |n| "Organization ##{n}" }
    description { "We do things" }
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
      association :user, factory: :member_user
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
#  visible     :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_organizations_on_name     (name) UNIQUE
#  index_organizations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
