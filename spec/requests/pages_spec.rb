require 'rails_helper'

RSpec.xdescribe "Pages", type: :request do
  describe "GET /" do
    context "when user is an authenticated user" do
      let (:admin) { create(:admin_user) }
      let (:member) { create(:member_user) }
      it "redirects to the members home page" do
        get root_path(as: admin)
        expect(response).to redirect_to members_home_path
      end
      it "redirects to the members home page" do
        get root_path(as: admin)
        expect(response).to redirect_to members_home_path
      end
    end

    context "when user is not authenticated" do
      let (:guest) { create(:guest_user) }
      it "redirects to the guest home page" do
        get root_path
        expect(response).to redirect_to guests_home_path
      end
    end
  end
end