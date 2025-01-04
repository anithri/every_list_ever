require 'rails_helper'

RSpec.describe "Members", type: :request do
  describe "GET /home" do
    it "returns http success" do
      get "/members/home"
      expect(response).to have_http_status(:success)
    end
  end

end
