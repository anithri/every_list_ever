# Home many users in addition to Guest, Admin, and Developer
USER_MEMBER_COUNT = 20

# what ratio of 1 admin to ADMIN_RATIO members, random generation so specific counts will vary
ADMIN_RATIO = 5

# region Guest User
guest = User.find_or_create_by(name: 'Guest')
guest_pass = SecureRandom.base58(32) # random password for guest, not used anywhere else.
guest.update(
  id: 1,
  email_address: 'guest@example.com',
  password: guest_pass,
  password_confirmation: guest_pass,
  visible: false,
  membership: :guest,
  avatar_url: Faker::Avatar.image,
  description: "A guest user",
  location: "Anytown, Everywhere",
)
guest.update password_digest: guest.password_digest.first(4) # no logins ever for guest
# endregion

# region developer User
if ENV['DEVELOPER_NAME'].present? && ENV['DEVELOPER_EMAIL'].present?
  developer = User.find_or_create_by(name: ENV['DEVELOPER_NAME'])
  developer.update(
    id: 42,
    email_address: ENV['DEVELOPER_EMAIL'],
    password: ENV['DEVELOPER_PASS'],
    password_confirmation: ENV['DEVELOPER_PASS'],
    visible: true,
    membership: :admin,
    avatar_url: Faker::Avatar.image,
    description: "I'm just zis developer, you know?",
    location: "Someplace, Somewhere"
  )
end
# endregion

# region Admin User
admin = User.find_or_create_by(name: 'admin')
admin_pass = SecureRandom.base58(32) # random password for guest, not used anywhere else.
admin.update(
  id: 99,
  email_address: 'admin@example.com',
  password: admin_pass,
  password_confirmation: admin_pass,
  visible: true,
  membership: :admin,
  avatar_url: Faker::Avatar.image,
  description: "Admin User\npass: #{admin_pass}",
  location: "Someplace, Somewhere"
)
# endregion

# set the sequence to start at 100
User.connection.execute("ALTER SEQUENCE users_id_seq RESTART WITH 100;")

# region Users
all_users = []
USER_MEMBER_COUNT.times do
  pass = Faker::Internet.password
  membership = rand(ADMIN_RATIO).zero? ? :admin : :member
  location = rand(2).zero? ? Faker::Address.city(options: { with_state: true, with_country: true }) : Faker::University.name
  u = {
    email_address: Faker::Internet.email,
    password: pass,
    password_confirmation: pass,
    membership: membership,
    location: location,
    name: Faker::Name.name,
    visible: rand(2).zero?,
    avatar_url: Faker::Avatar.image,
    description: "#{membership.to_s.titleize} User\npassword = #{pass}",
  }
  all_users.push u
end
User.create(all_users)
# endregion

puts "Users Seeded: #{User.count}"
