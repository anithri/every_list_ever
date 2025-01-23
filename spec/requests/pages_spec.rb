require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /" do
    context "when user is an authenticated user" do
      let(:admin) { create(:admin_user) }
      let(:member) { create(:member_user) }
      it "redirects admin to members home" do
        get root_auth_path(as: admin)
        expect(response).to redirect_to members_home_path
      end
      it "redirects to the members home" do
        get root_auth_path(as: member)
        expect(response).to redirect_to members_home_path
      end
    end

    context "when user is not authenticated" do
      let(:guest) { create(:guest_user) }
      it "redirects to the guest home page" do
        get root_unauth_path
        expect(response).to redirect_to guests_home_path
      end
    end
  end
end
