require "rails_helper"
require_relative "../helper/factories_shared_examples"

user_factories = %i[ admin_user guest_user member_user ]
user_roles = %i[ admin guest member ]
user_vis = %i[ visible invisible ]

RSpec.describe "User Factories", type: :model do
  user_factories.each do |user_type|
    include_examples "shared examples", user_type, User
    include_examples "user examples", user_type, User
  end
  user_roles.product(user_vis).each do |(role, vis)|
    include_examples "user trait examples", :user, role, vis
  end
end
