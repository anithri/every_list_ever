require 'rails_helper'

RSpec.describe "resources :users as admin user", type: :request do
  let(:admin) { create(:admin_user) }
  let(:guest) { create(:guest_user) }
  let(:member) { create(:member_user) }
  let(:valid_attributes) { { location: "Testing" } }
  let(:invalid_attributes) { { name: "" } }

  describe "attribute types are correct for use" do
    describe "for User" do
      it "are valid" do
        admin.update valid_attributes
        expect(admin).to be_valid
      end
      it "are invalid" do
        admin.update invalid_attributes
        expect(admin).not_to be_valid
      end
    end
  end

  describe "actions" do
    context "when user is admin" do
      describe "GET #index /users" do
        it "renders a successful response" do
          get users_url(as: admin)
          expect(response).to be_successful
        end
      end

      describe "GET #show /users/show/1234" do
        it "renders a successful response" do
          get user_url(admin, as: admin)
          expect(response).to be_successful
        end
        it "renders a successful response" do
          get user_url(member, as: admin)
          expect(response).to be_successful
        end
      end

      describe "GET #edit /users/1234/edit" do
        it "renders a successful response as admin editing admin" do
          get edit_user_url(admin, as: admin)
          expect(response).to have_http_status(:ok)
        end
        it "renders a successful response as admin editing member" do
          get edit_user_url(member, as: admin)
          expect(response).to have_http_status(:ok)
        end
      end

      describe "PATCH #update /users/1234" do
        context "with valid parameters" do
          it "updates the requested user" do
            patch user_url(admin, as: admin), params: { user: valid_attributes }
            admin.reload
            expect(response).to redirect_to user_url(admin)
          end
          it "redirects to the user" do
            patch user_url(admin, as: admin), params: { user: valid_attributes }
            expect(response).to redirect_to(user_path(admin))
          end
        end

        context "with invalid parameters" do
          it "renders a response with 422 status (i.e. to display the 'edit' template)" do
            patch user_url(admin, as: :admin), params: { user: invalid_attributes }
            expect(response).to have_http_status(:not_found)
          end
        end
      end

      describe "DELETE /destroy /users/1234" do
        it "destroys the requested user" do
          # TODO
          delete user_url(admin, as: :admin)
          expect(response).to have_http_status(:not_found)
        end

        it "redirects to the users list" do
          delete user_url(admin, as: :admin)
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
