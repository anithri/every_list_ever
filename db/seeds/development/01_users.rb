puts "Seeding #{RECORD_COUNTS[:users]} users"

anithri = User.find_or_create_by( email_address: 'anithri@gmail.com')
anithri.update(password: 'artemis.', password_confirmation: 'artemis.')
RECORD_COUNTS[:users].times do |n|
  pass = Faker::Internet.password
  User.create email_address: Faker::Internet.email,
              password: pass,
              password_confirmation: pass

end

ALL_RECORDS[:users] = User.all
