require 'rails_helper'

RSpec.describe "organizations/new", type: :view do
  before(:each) do
    assign(:organization, Organization.new(
      name: "MyString",
      subtitle: "MyString",
      description: "MyText",
      owner: nil,
      visible: false
    ))
  end

  it "renders new organization form" do
    render

    assert_select "form[action=?][method=?]", organizations_path, "post" do

      assert_select "input[name=?]", "organization[name]"

      assert_select "input[name=?]", "organization[subtitle]"

      assert_select "textarea[name=?]", "organization[description]"

      assert_select "input[name=?]", "organization[owner_id]"

      assert_select "input[name=?]", "organization[visible]"
    end
  end
end
