# frozen_string_literal: true
module MembershipComponents
  class ByUser < Base
    include Phlex::Rails::Helpers::Routes
    include Phlex::Rails::Helpers::LinkTo
    include ComponentsHelper
    include CardHelper

    def view_template
      div class: "flex flex-col gap-2" do
        memberships.each do |membership|
          link_to user_path(membership.user) do
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
