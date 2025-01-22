require "rails_helper"
require_relative "../helper/factories_shared_examples"

org_factories = %i[ admin_org member_org ]
org_owners = %i[ admin member ]
org_vis = %i[ visible invisible ]

RSpec.describe "Organization Factories", type: :model do
  org_factories.each do |user_type|
    include_examples "shared examples", user_type, Organization
    include_examples "organization examples", user_type, Organization
  end
  org_owners.product(org_vis).each do |(role, vis)|
    include_examples "organization trait examples", :organization, role, vis
  end
end
