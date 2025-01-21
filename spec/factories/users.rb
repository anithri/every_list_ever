FactoryBot.define do
  sequence(:email) { |n| "person#{n}@example.com" }
  sequence(:name) { |n| "User ##{n}" }
  factory :base_user, class: "User" do
    email
    name
    avatar_url { "MyString" }
    description { "MyText" }
    location { "MyString" }
    password { "password" }
    trait :admin do
      site_role { :admin }
    end
    trait :guest do
      site_role { :guest }
    end
    trait :member do
      site_role { :member }
    end
    trait :invisible do
      visible { false }
    end
    trait :visible do
      visible { true }
    end
    factory :admin_user, traits: [:admin, :visible]
    factory :guest_user, traits: [:guest, :visible]
    factory :member_user, traits: [:member, :visible], aliases: [:user]
  end
end

# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  avatar_url         :string
#  confirmation_token :string(128)
#  confirmed_at       :datetime
#  deleted_at         :datetime
#  description        :text
#  email              :string           not null
#  encrypted_password :string(128)      not null
#  location           :string
#  name               :string           not null
#  remember_token     :string(128)      not null
#  settings           :json             not null
#  site_role          :integer          default("guest"), not null
#  visible            :string           default("false"), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token  (confirmation_token) UNIQUE
#  index_users_on_confirmed           (confirmed_at) WHERE (deleted_at IS NULL)
#  index_users_on_confirmed_at_null   (confirmed_at) WHERE (deleted_at IS NULL)
#  index_users_on_deleted_at          (deleted_at) WHERE (deleted_at IS NOT NULL)
#  index_users_on_deleted_at_null     (deleted_at) WHERE (deleted_at IS NULL)
#  index_users_on_email               (email) UNIQUE
#  index_users_on_name                (name) UNIQUE
#  index_users_on_remember_token      (remember_token) UNIQUE
#  index_users_on_site_role           (site_role)
#  index_users_on_visible             (visible)
#
