DEFAULT_RECORD_COUNT = 10
RECORD_COUNTS = Hash.new(DEFAULT_RECORD_COUNT)
RECORD_COUNTS[:users] = 20
RECORD_COUNTS[:organizations] = 5
RECORD_COUNTS[:organization_members] = 50

ALL_RECORDS = Hash.new { |h, k| h[k] = [] }

Dir[Rails.root.join("db/seeds/#{Rails.env}/*.rb")].sort.each do |file|
  puts "Processing #{file.split('/').last}"
  require file
end