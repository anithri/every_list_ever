require 'rails_helper'

RSpec.describe "Members", type: :request do
  let (:member_session) { create(:member_session) }
  describe "GET /home" do
    it "returns http success for member user" do
      Current.session = member_session
      get "/members/home"
      expect(response).to have_http_status(:success)
    end
  end

end
