FactoryBot.define do
  factory :organization do
    name { "MyString" }
    subtitle { "MyString" }
    description { "MyText" }
    owner { nil }
    visible { false }
  end
end
