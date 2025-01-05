require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    assign(:user, User.create!(
      email_address: "one@example.com",
      name: "User One",
      password_digest: "Password Digest",
      visible: false,
      membership: :member,
      avatar_url: "Avatar Url",
      description: "MyText",
      location: "Location"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email address/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Visible/)
    expect(rendered).to match(/Membership/)
    expect(rendered).to match(/Avatar url/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Location/)
  end
end
