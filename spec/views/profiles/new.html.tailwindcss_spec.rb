require 'rails_helper'

RSpec.describe "profiles/new", type: :view do
  before(:each) do
    assign(:profile, Profile.new(
      avatar: "MyString",
      description: "MyText",
      location: "MyString",
      user: nil
    ))
  end

  it "renders new profile form" do
    render

    assert_select "form[action=?][method=?]", profiles_path, "post" do

      assert_select "input[name=?]", "profile[avatar]"

      assert_select "textarea[name=?]", "profile[description]"

      assert_select "input[name=?]", "profile[location]"

      assert_select "input[name=?]", "profile[user_id]"
    end
  end
end
