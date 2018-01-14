$admin_db = $client.use('admin')
$admin_db.command(listDatabases: 1).each do |doc|
  doc.each do |key, value|
    print "#{key} => "
    if (!value.respond_to?(:each))
      puts value
    else
      puts "\n"
      value.each do |db|
          puts "  #{db}"
      end
    end
  end
end

puts 'Dropping `users`'
db = $client.use('tutorial')
db['users'].drop
p $admin_db.command(listCollections: 1)
