require 'rails_helper'

RSpec.describe "profiles/edit", type: :view do
  let(:profile) {
    Profile.create!(
      avatar: "MyString",
      description: "MyText",
      location: "MyString",
      user: nil
    )
  }

  before(:each) do
    assign(:profile, profile)
  end

  it "renders the edit profile form" do
    render

    assert_select "form[action=?][method=?]", profile_path(profile), "post" do

      assert_select "input[name=?]", "profile[avatar]"

      assert_select "textarea[name=?]", "profile[description]"

      assert_select "input[name=?]", "profile[location]"

      assert_select "input[name=?]", "profile[user_id]"
    end
  end
end
