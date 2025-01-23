require "rails_helper"

RSpec.xdescribe MembersController, type: :routing do
  # TODO find a way to test routing while respecting constraints
  describe "routing" do
    it "routes to root" do
      expect(get: "/").to route_to("pages#root")
    end
  end
end
