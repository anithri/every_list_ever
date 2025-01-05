require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  let(:user) {
    User.create!(
      email_address: "one@example.com",
      name: "User One",
      password_digest: "MyString",
      visible: false,
      membership: :member,
      avatar_url: "MyString",
      description: "MyText",
      location: "MyString"
    )
  }

  before(:each) do
    assign(:user, user)
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(user), "post" do

      assert_select "input[name=?]", "user[email_address]"

      assert_select "input[name=?]", "user[name]"

      assert_select "input[name=?]", "user[password_digest]"

      assert_select "input[name=?]", "user[visible]"

      assert_select "input[name=?]", "user[membership]"

      assert_select "input[name=?]", "user[avatar_url]"

      assert_select "textarea[name=?]", "user[description]"

      assert_select "input[name=?]", "user[location]"
    end
  end
end
