require 'rails_helper'

RSpec.describe "/users", type: :request do
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
    context "when user is member" do
      describe "GET #index /users" do
        it "renders a successful response" do
          get users_url(as: member)
          expect(response).to be_successful
        end
      end

      describe "GET #show /users/show/1234" do
        it "renders a successful response" do
          get user_url(admin, as: member)
          expect(response).not_to be_successful
        end
        it "renders a successful response" do
          get user_url(member, as: member)
          expect(response).to be_successful
        end
      end

      describe "GET #edit /users/1234/edit" do
        it "renders a successful response as admin editing admin" do
          get edit_user_url(admin, as: member)
          expect(response).not_to be_successful
        end
        it "renders a successful response as admin editing member" do
          get edit_user_url(member, as: member)
          expect(response).to be_successful
        end
      end

      describe "PATCH #update /users/1234" do
        context "with valid parameters" do
          let(:new_attributes) {
            skip("Add a hash of attributes valid for your model")
          }

          it "updates the requested user" do
            user = User.create! valid_attributes
            patch user_url(user), params: { user: new_attributes }
            user.reload
            skip("Add assertions for updated state")
          end

          it "redirects to the user" do
            user = User.create! valid_attributes
            patch user_url(user), params: { user: new_attributes }
            user.reload
            expect(response).to redirect_to(user_url(user))
          end
        end

        context "with invalid parameters" do
          it "renders a response with 422 status (i.e. to display the 'edit' template)" do
            user = User.create! valid_attributes
            patch user_url(user), params: { user: invalid_attributes }
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end

      describe "DELETE /destroy" do
        it "destroys the requested user" do
          user = User.create! valid_attributes
          expect {
            delete user_url(user)
          }.to change(User, :count).by(-1)
        end

        it "redirects to the users list" do
          user = User.create! valid_attributes
          delete user_url(user)
          expect(response).to redirect_to(users_url)
        end
      end
    end
  end
end