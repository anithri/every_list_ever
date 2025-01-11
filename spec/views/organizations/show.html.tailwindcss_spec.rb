require 'rails_helper'

RSpec.describe "organizations/show", type: :view do
  before(:each) do
    assign(:organization, Organization.create!(
      name: "Name",
      subtitle: "Subtitle",
      description: "MyText",
      owner: nil,
      visible: false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Subtitle/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
