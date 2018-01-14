$users.find(last_name: 'Mr. Smith').update_one('$set' => {city: 'Chicago'})
p $users.find(last_name: 'Mr. Smith').to_a

$users.find(age: {'$gte' => 30}).update_many('$set' => {job: 'Bit Twiddler'})
p $users.find(age: {'$gte' => 30}).to_a
