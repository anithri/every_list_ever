require 'rails_helper'

RSpec.describe "organizations/edit", type: :view do
  let(:organization) {
    Organization.create!(
      name: "MyString",
      subtitle: "MyString",
      description: "MyText",
      owner: nil,
      visible: false
    )
  }

  before(:each) do
    assign(:organization, organization)
  end

  it "renders the edit organization form" do
    render

    assert_select "form[action=?][method=?]", organization_path(organization), "post" do

      assert_select "input[name=?]", "organization[name]"

      assert_select "input[name=?]", "organization[subtitle]"

      assert_select "textarea[name=?]", "organization[description]"

      assert_select "input[name=?]", "organization[owner_id]"

      assert_select "input[name=?]", "organization[visible]"
    end
  end
end
