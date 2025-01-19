# frozen_string_literal: true

require 'rails_helper'

RSpec.xdescribe "Members", type: :request do
  before do
  end
  describe "GET /" do
    context "when user is member" do
      let (:session) { create(:registered_session) }
      before do
        allow_any_instance_of(Current).to receive(:session).and_return(session)
      end

      it "returns a successful response" do
        get root_path
        warn [Current.session.id, Current.session.id, Current.user.id].inspect
        expect(response).to have_http_status(:ok)
      end
    end
    context "when user is member" do
      let (:session) { create(:admin_session) }
      before do
        allow_any_instance_of(Current).to receive(:session).and_return(session)
      end

      it "returns a successful response" do
        warn Current.session
        get root_path
        expect(response).to have_http_status(:ok)
      end
    end
    context "when user is not authorized" do
      before do
        allow_any_instance_of(MembersController).to receive(:authorize).with(:registered_home_path).and_raise(Pundit::NotAuthorizedError)
      end

      it "redirects to the login page" do
        get root_path
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
end
