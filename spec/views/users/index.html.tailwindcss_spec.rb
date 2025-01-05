require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        email_address: "one@cppwind.com",
        name: "Name One",
        password_digest: "Password Digest",
        visible: false,
        membership: :member,
        avatar_url: "Avatar Url",
        description: "MyText",
        location: "Location"
      ),
      User.create!(
        email_address: "two@cppwind.com",
        name: "Name Two",
        password_digest: "Password Digest",
        visible: false,
        membership: :member,
        avatar_url: "Avatar Url",
        description: "MyText",
        location: "Location"
      )
    ])
  end

  it "renders a list of users" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Email address".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Password Digest".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Visible".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Membership".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Avatar url".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Description".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Location".to_s), count: 2
  end
end
