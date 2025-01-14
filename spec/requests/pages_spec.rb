require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /home" do
    it "returns a successful response" do
      get home_path
      expect(response).to have_http_status(:ok)
    end

    it "displays the welcome notice" do
      get home_path
      expect(flash[:notice]).to eq("Welcome to the home page!")
    end

    it "displays the login alert" do
      get home_path
      expect(flash[:alert]).to eq("Login or create a new user.")
    end
  end

  describe "GET /root" do
    context "when user is authenticated" do
      before do
        allow_any_instance_of(ApplicationController).to receive(:authenticated?).and_return(true)
      end

      it "redirects to the members home page" do
        get root_path
        expect(response).to redirect_to(members_home_path)
      end
    end

    context "when user is not authenticated" do
      before do
        allow_any_instance_of(ApplicationController).to receive(:authenticated?).and_return(false)
      end

      it "redirects to the guest home page" do
        get root_path
        expect(response).to redirect_to(guest_home_path)
      end
    end
  end
end