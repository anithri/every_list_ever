require 'rails_helper'

RSpec.describe "GuestsController", type: :request do
  let (:guest) { create(:guest_user) }

  describe "actions" do
    context "as guest" do
      describe "GET #home /guest" do
        it "returns http success" do
          get guests_home_path(as: guest)
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
