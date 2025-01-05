require 'rails_helper'

RSpec.describe "profiles/index", type: :view do
  before(:each) do
    assign(:profiles, [
      Profile.create!(
        handle: "Handle",
        avatar: "Avatar",
        description: "MyText",
        location: "Location",
        visibility: false,
        user: nil
      ),
      Profile.create!(
        handle: "Handle",
        avatar: "Avatar",
        description: "MyText",
        location: "Location",
        visibility: false,
        user: nil
      )
    ])
  end

  it "renders a list of profiles" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Handle".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Avatar".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Location".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
