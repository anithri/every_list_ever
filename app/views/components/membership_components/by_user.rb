# frozen_string_literal: true
module MembershipComponents
  class ByUser < Base
    include Phlex::Rails::Helpers::Routes
    include Phlex::Rails::Helpers::LinkTo
    include ComponentsHelper
    include CardHelper

    def view_template
      div class: "flex flex-col gap-2" do
        memberships.each do |member|
          link_to organization_path(member.organization) do
            card :info_aside, member.organization.name, member.role do
              span { "Orgs: 3" }
              span { "117 :Votes" }
            end
          end
        end
      end
    end
  end
end
