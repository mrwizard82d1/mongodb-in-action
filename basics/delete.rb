$users.find(last_name: 'mtsouk').delete_one
puts 'After deleting one'
$users.find().each do | doc |
  puts doc
end

$users.find(age: {'$gte' => 30}).delete_many
puts 'After deleting many'
$users.find().each do | doc |
  puts doc
end

$users.drop()
puts 'Look, Ma! Nothing left.'
$users.find().each do | doc |
  puts doc
end