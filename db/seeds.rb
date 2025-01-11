Dir[Rails.root.join("db/seeds/#{Rails.env}/*.rb")].sort.each do |file|
  puts "Processing #{file.split('/').last}"
  require file
end

