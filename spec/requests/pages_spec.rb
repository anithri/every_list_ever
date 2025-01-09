require 'rails_helper'

RSpec.xdescribe "Pages", type: :request do
  describe "GET /home" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

end
