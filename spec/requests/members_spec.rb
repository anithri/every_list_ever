# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Members", type: :request do
  let (:admin) { create(:admin_user) }
  let (:guest) { create(:guest_user) }
  let (:member) { create(:member_user) }
  describe "GET /" do
    context "when user is admin" do
      it "returns a successful response" do
        get members_home_path(as: admin)
        expect(response).to have_http_status(:ok)
      end
      it "redirects '/' to members_home" do
        get root_path(as: admin)
        expect(response).to redirect_to(members_home_path)
      end
    end
    context "when user is guest" do
      it "redirects to login" do
        get members_home_path
        expect(response).to redirect_to sign_in_path
      end
    end
    context "when user is member" do
      it "returns a successful response" do
        get members_home_path(as: member)
        expect(response).to have_http_status(:ok)
      end

      it "redirects '/' to members_home" do
        get root_path(as: member)
        expect(response).to redirect_to(members_home_path)
      end
    end
  end
end
