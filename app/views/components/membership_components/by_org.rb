# frozen_string_literal: true
module MembershipComponents
  class ByOrg < Base
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::Routes
    include CardHelper
    def view_template
      div class: "" do
        memberships.each do |membership|
          link_to organization_path(membership.organization) do
            card :info_aside, membership.user.name, membership.role do
              span { "Orgs: 3" }
              span { "117 :Votes" }
            end
          end
        end
      end
    end
  end
end
