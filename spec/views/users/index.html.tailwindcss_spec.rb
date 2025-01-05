require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        email_address: "Email Address",
        name: "Name",
        password_digest: "Password Digest",
        visible: false,
        membership: "Membership",
        avatar_url: "Avatar Url",
        description: "MyText",
        location: "Location"
      ),
      User.create!(
        email_address: "Email Address",
        name: "Name",
        password_digest: "Password Digest",
        visible: false,
        membership: "Membership",
        avatar_url: "Avatar Url",
        description: "MyText",
        location: "Location"
      )
    ])
  end

  it "renders a list of users" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Email Address".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Password Digest".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Membership".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Avatar Url".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Location".to_s), count: 2
  end
end
