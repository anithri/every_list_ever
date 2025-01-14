FactoryBot.define do
  factory :admin_user, class: "User" do
    avatar_url { "MyString" }
    description { "MyText" }
    email_address { "admin@example.com" }
    location { "MyString" }
    site_role { :admin }
    name { "Admin" }
    password_digest { "password" }
    visible { true }
  end
  factory :guest_user, class: "User" do
    avatar_url { "MyString" }
    description { "MyText" }
    email_address { "guest@abc.123.example.dev" }
    location { "MyString" }
    site_role { :guest }
    name { "Guest" }
    password_digest { "password" }
    visible { true }
  end
  factory :registered_user, class: "User" do
    avatar_url { "MyString" }
    description { "MyText" }
    email_address { "registrated_user@example.com" }
    location { "MyString" }
    site_role { :registered }
    name { "Registered User" }
    password_digest { "password" }
    visible { true }
  end
  factory :invisible_user, class: "User" do
    avatar_url { "MyString" }
    description { "MyText" }
    email_address { "invisible@example.com" }
    site_role { :registered }
    location { "MyString" }
    name { "Invisible Member" }
    password_digest { "password" }
    visible { false }
  end
end

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  avatar_url      :string
#  description     :string
#  email_address   :string           not null
#  location        :string
#  name            :string           not null
#  password_digest :string           not null
#  site_role       :integer          default("guest")
#  visible         :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#  index_users_on_name           (name) UNIQUE
#
