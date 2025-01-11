# frozen_string_literal: true

require 'rails_helper'

verifier = ActiveSupport::MessageVerifier.new(Rails.application.secret_key_base)

RSpec.describe "Members", type: :request do
  let (:member_session) { create(:member_session) }

  it "should have a way to set specific user" do
    pending "trying to figure it out"
  end

  # TODO still struggling with setting a specific user for request specs
  describe "GET /" do
    it "returns http success for member user" do
      Current.session = member_session
      cookies[:session_id] =  verifier.generate(Current.session.id)
      get "/"

      Current.session = member_session

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to("/members/#{Current.session.user.id}")
    end
  end

end
