$users.insert_one({last_name: 'mtsouk'})
$users.insert_one({last_name: 'knuth'})

$users.find().each do | user |
  puts user
end

mr_smith = {last_name: 'Mr. Smith', age: 30}
mr_anderson = {last_name: 'Mr. Anderson', age: 40}

mr_smith_id = $users.insert_one(mr_smith)
mr_anderson_id = $users.insert_one(mr_anderson)

p $users.find(age: {'$gt' => 20}).to_a.each

