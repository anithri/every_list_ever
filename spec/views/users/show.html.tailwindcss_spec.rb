require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    assign(:user, User.create!(
      email_address: "Email Address",
      name: "Name",
      password_digest: "Password Digest",
      visible: false,
      membership: "Membership",
      avatar_url: "Avatar Url",
      description: "MyText",
      location: "Location"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email Address/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Password Digest/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Membership/)
    expect(rendered).to match(/Avatar Url/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Location/)
  end
end
