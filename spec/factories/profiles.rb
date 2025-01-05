FactoryBot.define do
  factory :profile do
    handle { "MyString" }
    avatar { "MyString" }
    description { "MyText" }
    location { "MyString" }
    visibility { false }
    user { nil }
  end
end

# == Schema Information
#
# Table name: profiles
#
#  id          :bigint           not null, primary key
#  avatar      :string
#  description :text
#  handle      :string           not null
#  location    :string
#  visibility  :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_profiles_on_handle   (handle) UNIQUE
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
