# frozen_string_literal: true

ORGANIZATIONS_COUNT = 12
all = User.all.to_a
DEVELOPER = User.find_by(name: ENV["DEVELOPER_NAME"])
ALL_OWNERS = all.shuffle.first(ORGANIZATIONS_COUNT)
all_orgs = []

if DEVELOPER.present?
  org = {
    name: 'Wooticus Prime',
    subtitle: "'A developer's organization'",
    description: 'A place for developers to share their lists.',
    owner: DEVELOPER,
    visible: true
  }
  all_orgs.push(org)
end

ALL_OWNERS.each do |owner|
  org = {
    name: Faker::Company.name.truncate(30),
    subtitle: Faker::Company.catch_phrase,
    description: Faker::Company.catch_phrase,
    owner: owner,
    visible: rand(5).zero?
  }
  all_orgs.push(org)
end
Organization.create(all_orgs)

puts "Organizations Seeded: #{Organization.count}"
