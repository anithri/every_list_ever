FactoryBot.define do
  factory :admin_session, class: "Session" do
    user { build :admin_user }
  end
  factory :guest_session, class: "Session" do
    user { build :guest_user }
  end
  factory :member_session, class: "Session" do
    user { build :member_user }
  end
end
