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
          get organizations_path(as: member)
          expect(response).to have_http_status(:ok)
        end
      end

      describe "GET #show /users/show/1234" do
        it "renders a successful response" do
          get organization_path(member, as: member)
          expect(response).to have_http_status(:ok)
        end
        it "renders a successful response" do
          get organization_path(member, as: member)
          expect(response).to have_http_status(:ok)
        end
      end

      describe "GET #edit /users/1234/edit" do
        it "renders a successful response" do
          get edit_organization_path(member, as: member)
          expect(response).to have_http_status(:ok)
        end
      end

      describe "PATCH #update /users/1234" do
        context "with valid parameters" do
          it "updates the requested user" do
            user = User.create! attributes_for(:member_user)
            patch organization_path(user, as: user), params: { organization: valid_attributes }
            user.reload
            valid_attributes.each do |key, value|
              expect(user.send(key)).to eq(value)
            end
          end

          it "redirects to the user" do
            user = User.create! attributes_for :member_user
            patch organization_path(user, as: user), params: { organization: valid_attributes }
            expect(response).to redirect_to(organization_path(user))
          end
        end

        context "with invalid parameters" do
          it "renders a response with 422 status (i.e. to display the 'edit' template)" do
            user = User.create! attributes_for :member_user
            patch organization_path(user, as: user), params: { organization: invalid_attributes }
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end

      describe "DELETE /destroy" do
        it "destroys the requested user" do
          user = User.create! attributes_for :member_user
          orig_count = User.count
          delete organization_path(user, as: user)
          expect(User.count).to eq(orig_count)
        end

        it "redirects to the users list" do
          user = User.create! attributes_for :member_user
          delete organization_path(user, as: user)
          expect(response).to have_http_status(:redirect)
        end
      end
    end
  end
end
