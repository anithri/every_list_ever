require 'rails_helper'

RSpec.describe "/organizations", type: :request do
  let(:valid_attributes) { { subtitle: "Testing" } }
  let(:invalid_attributes) { { owner: nil } }
  let(:member) { User.create!(attributes_for :member_user) }
  let(:org) { Organization.create!(attributes_for(:organization).merge(owner: member)) }

  describe "attribute types for use in Organizations" do
    it "are valid" do
      org.assign_attributes valid_attributes
      expect(org).to be_valid
    end
    it "are invalid" do
      org.assign_attributes invalid_attributes
      expect(org).not_to be_valid
    end
  end

  describe "actions" do

    context "when user is member" do
      describe "GET #index /guests" do
        it "renders a successful response" do
          member = create(:member_user)
          get organizations_path(as: member)
          expect(response).to have_http_status(200)
        end
      end

      describe "GET #show /organizations/1234" do
        it "renders a successful response" do
          get organization_path(org, as: member)
          expect(response).to have_http_status(200)
        end
      end

      describe "GET #new /organizations/new" do
        it "renders a successful response" do
          get new_organization_path(as: :member)
          expect(response).to have_http_status(200)
        end
      end

      describe "GET #edit /organizations/1234/edit" do
        it "renders a successful response" do
          member = create(:member_user)

          org = Organization.create! attributes_for(:organization, visible: true, owner: member)
          get edit_organization_path(org, as: :member)
          expect(response).to have_http_status(200)
        end
      end

      describe "POST #create /organizations/1234/create" do
        context "with valid parameters" do
          it "creates a new org = Organization" do
            member = create(:member_user)

            org = Organization.create! attributes_for(:organization, visible: true, owner: member)
            expect {
              post organizations_path(as: :member), params: { organization: valid_attributes }
            }.to change(org, :count).by(1)
          end

          it "redirects to the created organization" do
            member = create(:member_user)
            warn member.inspect
            org = Organization.create! attributes_for(:organization, visible: true, owner: member)
            post organizations_path(as: :member), params: { organization: valid_attributes }
            expect(response).to redirect_to(organization_path(org = Organization.last))
          end
        end
        context "with invalid parameters" do
          it "does not create a new org = Organization" do
            member = create(:member_user)
            expect {
              post organizations_path(as: :member), params: { organization: invalid_attributes }
            }.to change(org, :count).by(0)
          end

          it "renders a response with 422 status (i.e. to display the 'new' template)" do
            member = create(:member_user)
            post organizations_path(as: :member), params: { organization: invalid_attributes }
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end

      describe "PATCH #update /organizations/1234/update" do
        context "with valid parameters" do
          let(:new_attributes) {
            skip("Add a hash of attributes valid for your model")
          }

          it "updates the requested organization" do
            member = create(:member_user)
            org = Organization.create! attributes_for(:organization, visible: true, owner: member)
            patch organization_path(org, as: :member), params: { organization: new_attributes }
            organization.reload
            skip("Add assertions for updated state")
          end

          it "redirects to the organization" do
            member = create(:member_user)
            org = Organization.create! attributes_for(:organization, visible: true, owner: member)
            patch organization_path(organization, as: :member), params: { organization: new_attributes }
            organization.reload
            expect(response).to redirect_to(organization_path(org))
          end
        end

        context "with invalid parameters" do
          it "renders a response with 422 status (i.e. to display the 'edit' template)" do
            member = create(:member_user)
            org = Organization.create! attributes_for(:organization, visible: true, owner: member)
            patch organization_path(org, as: :member), params: { organization: invalid_attributes }
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end

      describe "DELETE #delete /organizations/1234" do
        it "destroys the requested organization" do
          member = create(:member_user)
          org = Organization.create! attributes_for(:organization, visible: true, owner: member)
          expect {
            delete organization_path(org, as: :member)
          }.to change(org, :count).by(-1)
        end

        it "redirects to the organizations list" do
          member = create(:member_user)
          org = Organization.create! attributes_for(:organization, visible: true, owner: member)
          delete organization_path(org)
          expect(response).to redirect_to(organizations_path, as: :member)
        end
      end
    end
  end
end