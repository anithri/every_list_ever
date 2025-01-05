FactoryBot.define do
  factory :admin_user, class: "User" do
    email_address { "admin@example.com" }
    name { "Admin" }
    password_digest { "password" }
    visible { true }
    membership { :admin }
    avatar_url { "MyString" }
    description { "MyText" }
    location { "MyString" }
  end
  factory :guest_user, class: "User" do
    email_address { "guest@example.com" }
    name { "Guest" }
    password_digest { "password" }
    visible { true }
    membership { :guest }
    avatar_url { "MyString" }
    description { "MyText" }
    location { "MyString" }
  end
  factory :member_user, class: "User" do
    email_address { "member@example.com" }
    name { "Member" }
    password_digest { "password" }
    visible { true }
    membership { :member }
    avatar_url { "MyString" }
    description { "MyText" }
    location { "MyString" }
  end
  factory :invisible_user, class: "User" do
    email_address { "invisible@example.com" }
    name { "Invisible Member" }
    password_digest { "password" }
    visible { false }
    membership { :member }
    avatar_url { "MyString" }
    description { "MyText" }
    location { "MyString" }
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
#  membership      :integer          default("guest")
#  name            :string           not null
#  password_digest :string           not null
#  visible         :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#  index_users_on_name           (name) UNIQUE
#
