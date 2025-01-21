# Home many users in addition to Guest, Admin, and Developer
USER_ROLE_COUNT = 20

# what ratio of 1 admin to ADMIN_RATIO registered users, random generation so specific counts will vary
ADMIN_RATIO = 5

# region Guest User
guest = User.find_or_create_by(name: 'Guest', email: "guest@nowhere.pop")
guest_pass = SecureRandom.base58(32) # random password for guest, not used anywhere else.
guest.update(
  id: 1,
  email: 'guest@example.com',
  password: guest_pass,
  visible: false,
  site_role: :guest,
  avatar_url: Faker::Avatar.image,
  description: "A guest user",
  location: "Anytown, Everywhere",
)
#endregion

# region developer User
if ENV['DEVELOPER_NAME'].present? && ENV['DEVELOPER_EMAIL'].present?
  developer = User.find_or_initialize_by(name: ENV['DEVELOPER_NAME'], email: ENV['DEVELOPER_EMAIL'],
  )
  developer.update(
    id: 42,
    password: ENV['DEVELOPER_PASS'],
    visible: true,
    site_role: :admin,
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
  email: 'admin@example.com',
  password: admin_pass,
  visible: true,
  site_role: :admin,
  avatar_url: Faker::Avatar.image,
  description: "Admin User\npass: #{admin_pass}",
  location: "Someplace, Somewhere"
)
# endregion

# set the sequence to start at 100
User.connection.execute("ALTER SEQUENCE users_id_seq RESTART WITH 100;")

# region Users
all_users = []
USER_ROLE_COUNT.times do
  pass = Faker::Internet.password
  site_role = rand(ADMIN_RATIO).zero? ? :admin : :member
  location = rand(2).zero? ? Faker::Address.city(options: { with_state: true, with_country: true }) : Faker::University.name
  u = {
    email: Faker::Internet.email,
    password: pass,
    site_role: site_role,
    location: location,
    name: Faker::Name.name.truncate(30),
    visible: rand(2).zero?,
    avatar_url: Faker::Avatar.image,
    description: "#{site_role.to_s.titleize} User\npassword = #{pass}",
  }
  all_users.push u
end
User.create(all_users)
# endregion

puts "Users Seeded: #{User.count}"
