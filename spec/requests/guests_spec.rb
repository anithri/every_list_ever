require 'rails_helper'

RSpec.describe "Guests", type: :request do
  describe "GET /home" do
    it "returns http success" do
      get "/guests/home"
      expect(response).to have_http_status(:success)
    end
  end

end
