users = User.all
roles = OrganizationMember.roles.keys
orgs = Organization.all

orgs.each do |org|
  valid_users = users.reject { |user| org.owner == user }.sample(rand 4..7)
  valid_users.each do |user|
    OrganizationMember.new(user: user, organization: org, role: roles.sample).save
  end
end
