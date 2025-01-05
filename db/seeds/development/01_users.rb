puts "Seeding #{RECORD_COUNTS[:users]} users"

anithri = User.find_or_create_by(name: 'anithri', email_address: 'anithri@gmail.com')
anithri.update(
  password: 'artemis.',
  password_confirmation: 'artemis.',
  visible: true,
  membership: :admin,
  profile_attributes: {
    avatar: Faker::Avatar.image,
    description: "Just this geek, you know?",
    location: "Colorado, USA"
  }
)
memberships = ([0] + Array.new(RECORD_COUNTS[:users] - 3) { 1 } + [2, 2]).shuffle
RECORD_COUNTS[:users].times do |n|
  pass = Faker::Internet.password
  User.create email_address: Faker::Internet.email,
              password: pass,
              password_confirmation: pass,
              name: Faker::Name.name,
              visible: rand(2).zero?,
              membership: memberships.pop,
              profile_attributes: {
                avatar: Faker::Avatar.image,
                description: Faker::Lorem.paragraph,
                location: rand(2).zero? ? Faker::Address.city(options: { with_state: true, with_country: true }) : Faker::University.name,
              }

end

ALL_RECORDS[:users] = User.all
