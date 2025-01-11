require 'rails_helper'

RSpec.describe "organizations/index", type: :view do
  before(:each) do
    assign(:organizations, [
      Organization.create!(
        name: "Name",
        subtitle: "Subtitle",
        description: "MyText",
        owner: nil,
        visible: false
      ),
      Organization.create!(
        name: "Name",
        subtitle: "Subtitle",
        description: "MyText",
        owner: nil,
        visible: false
      )
    ])
  end

  it "renders a list of organizations" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Subtitle".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MyText".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
  end
end
