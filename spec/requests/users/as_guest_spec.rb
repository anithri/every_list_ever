require 'rails_helper'
RSpec.describe "resources :organization as guest use", type: :request do
  let(:guest) { create(:guest_user) }
  let(:member) { create(:member_user) }

  describe "actions" do
    context "when user is guest" do
      describe "GET #index /users" do
        it "redirects to sign in page" do
          get organizations_path
          expect(response).to redirect_to new_sign_in_path
        end
      end

      describe "GET #show /users/show/1234" do
        it "redirects to sign in page" do
          get organization_path(member)
          expect(response).to redirect_to new_sign_in_path
        end
      end

      describe "GET #edit /users/1234/edit" do
        it "redirects to sign in page" do
          get edit_organization_path(member)
          expect(response).to redirect_to new_sign_in_path
        end
      end

      describe "PATCH #update /users/1234" do
        context "with any parameters" do
          it "redirects to sign in page" do
            put organization_path(member)
            expect(response).to redirect_to new_sign_in_path
          end
        end
      end

      describe "DELETE /destroy /users/1234" do
        it "redirects to sign in page" do
          delete organization_path(member)
          expect(response).to redirect_to new_sign_in_path
        end
      end
    end
  end
end
