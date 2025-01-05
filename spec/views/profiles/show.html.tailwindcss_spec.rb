require 'rails_helper'

RSpec.describe "profiles/show", type: :view do
  before(:each) do
    assign(:profile, Profile.create!(
      handle: "Handle",
      avatar: "Avatar",
      description: "MyText",
      location: "Location",
      visibility: false,
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Handle/)
    expect(rendered).to match(/Avatar/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
