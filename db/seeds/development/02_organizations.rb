# frozen_string_literal: true

all = User.all.to_a
ALL_AUTHORS = all.shuffle.first(12)
DEVELOPER = all.find { |u| u.name == ENV["DEVELOPER_NAME"] }
ORGANIZATIONS_COUNT = 12
all_orgs = []

if DEVELOPER.present?
  d = Organization.create(
    name: 'Wooticus Prime',
    subtitle: "'A developer's organization'",
    description: 'A place for developers to share their lists.',
    user: DEVELOPER,
    visible: true
  )
end

ALL_AUTHORS.each do |author|
  org = {
    name: Faker::Company.name,
    subtitle: Faker::Company.catch_phrase,
    description: Faker::Company.catch_phrase,
    user: author,
    visible: rand(5).zero?
  }
  all_orgs.push(org)
end
Organization.create(all_orgs)


puts "Organizations Seeded: #{Organization.count}"
