# frozen_string_literal: true

require 'rails_helper'

signed = "NDI=--9e55c814cb9221a2547901d9f7cd6fa7f415a222"

verifier = ActiveSupport::MessageVerifier.new(Rails.application.secret_key_base)


RSpec.describe "Members", type: :request do
  let (:member_session) { create(:member_session) }
  it "should have a way to set specific user" do
    pending "trying to figure it out"
  end

  describe "GET /home" do
    it "returns http success for member user" do
      Current.session = create(:member_session)
      cookies[:session_id] =  verifier.generate(Current.session.id)
      get "/members"
      warn '-' * 30
      warn request.inspect
      warn '=' * 30
      warn response.inspect
      warn '-' * 30

      expect(response).to have_http_status(:success)
    end
  end

end
