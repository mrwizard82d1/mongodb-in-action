p $users.find(:last_name  => 'Mr. Smith').to_a

p $users.find(:age  => {'$gt' => 30}).to_a

$users.find(:age  => {'$gt' => 30}).each do | doc |
  puts doc['last_name']
end
