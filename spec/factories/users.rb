FactoryBot.define do
  factory :user do
    email_address { "MyString" }
    name { "MyString" }
    password_digest { "MyString" }
    visible { false }
    membership { "MyString" }
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
