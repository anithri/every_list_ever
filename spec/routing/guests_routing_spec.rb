require "rails_helper"

RSpec.describe GuestsController, type: :routing do
  describe "routing" do
    it "routes to root" do
      expect(get: "/guest").to route_to("guests#homw")
    end
  end
end
