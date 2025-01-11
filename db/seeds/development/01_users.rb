puts "Seeding #{RECORD_COUNTS[:users] + 2} users"

guest = User.find_or_create_by(name: 'Guest', email_address: 'guest@example.com')
guest_pass = SecureRandom.base58(32) # random password for guest, not used anywhere else.
guest.update(
  id: 13,
  password: guest_pass,
  password_confirmation: guest_pass,
  visible: false,
  membership: :guest,
  avatar_url: Faker::Avatar.image,
  description: "A guest user",
  location: "Anytown, Everywhere",
)
guest.update password_digest: guest.password_digest.first(4) # no logins ever for guest

anithri = User.find_or_create_by(name: 'anithri', email_address: 'anithri@gmail.com')
anithri.update(
  id: 42,
  password: 'artemis.',
  password_confirmation: 'artemis.',
  visible: true,
  membership: :admin,
  avatar_url: Faker::Avatar.image,
  description: "Just this geek, you know?",
  location: "Colorado, USA"
)

memberships = (Array.new(RECORD_COUNTS[:users] - 2) { 1 } + [2, 2]).shuffle
RECORD_COUNTS[:users].times do |n|
  pass = Faker::Internet.password
  User.create email_address: Faker::Internet.email,
              password: pass,
              password_confirmation: pass,
              name: Faker::Name.name,
              visible: rand(2).zero?,
              membership: memberships.pop,
              avatar_url: Faker::Avatar.image,
              description: "test/development password = #{pass}",
              location: rand(2).zero? ? Faker::Address.city(options: { with_state: true, with_country: true }) : Faker::University.name

end

ALL_RECORDS[:users] = User.all
