require 'rails_helper'

RSpec.describe "/organizations", type: :request do
  let(:admin) { create(:admin_user) }
  let(:guest) { create(:guest_user) }
  let(:member) { create(:member_user) }
  let(:member2) { create(:member_user) }
  let(:valid_attributes) { { subtitle: "Testing" } }
  let(:invalid_attributes) { { name: "" } }
  let(:org) { create :organization, :visible, owner: member2 }
  let(:admin_org) { create :organization, :visible, owner: admin }
  let(:member_org) { create :organization, :visible, owner: member }

  describe "attribute types are correct for use" do
    describe "for Organization" do
      it "are valid" do
        admin_org.update valid_attributes
        expect(admin).to be_valid
      end
      it "are invalid" do
        admin_org.update invalid_attributes
        expect(admin_org).not_to be_valid
      end
    end
  end

  describe "actions" do
    context "when organization is member" do
      describe "GET #index /organizations" do
        it "renders a successful response" do
          get organizations_path(as: member)
          expect(response).to have_http_status(:ok)
        end
      end

      describe "GET #show /organizations/show/1234" do
        it "renders a successful response" do
          get organization_path(member_org, as: member)
          expect(response).to have_http_status(:ok)
        end
        it "renders a successful response" do
          get organization_path(member_org, as: member)
          expect(response).to have_http_status(:ok)
        end
      end

      describe "GET #edit /organizations/1234/edit" do
        it "renders a successful response" do
          get edit_organization_path(member_org, as: member)
          expect(response).to have_http_status(:ok)
        end
      end

      describe "PATCH #update /organizations/1234" do
        context "with valid parameters" do
          it "updates the requested organization" do
            patch organization_path(member_org, as: member), params: { organization: valid_attributes }
            member_org.reload
            valid_attributes.each do |key, value|
              expect(member_org.send(key)).to eq(value)
            end
          end

          it "redirects to the organization" do
            patch organization_path(member_org, as: member), params: { organization: valid_attributes }
            expect(response).to redirect_to(organization_path(member_org))
          end
        end

        context "with invalid parameters" do
          it "renders a response with 422 status (i.e. to display the 'edit' template)" do
            patch organization_path(member_org, as: member), params: { organization: invalid_attributes }
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end

      describe "DELETE /destroy" do
        it "destroys the requested organization" do
          orig_count = Organization.count
          delete organization_path(member_org, as: member)
          expect(Organization.count).to eq(orig_count)
        end

        it "redirects to the organizations list" do
          delete organization_path(member_org, as: member)
          expect(response).to redirect_to organizations_path
        end
      end
    end
  end
end
