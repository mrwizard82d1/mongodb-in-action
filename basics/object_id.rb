id = BSON::ObjectId.from_string('4c291856238d3b19b2000001')
p id

time_stamp = id.generation_time
p time_stamp

id_times = $client[:id_times]
id_times.insert_many([{_id: BSON::ObjectId.from_time(Time.utc(2013, 5, 30)), relative: 'before'},
                      {_id: BSON::ObjectId.from_time(Time.utc(2013, 6, 1)), relative: 'start'},
                      {_id: BSON::ObjectId.from_time(Time.utc(2013, 6, 15)), relative: 'middle'},
                      {_id: BSON::ObjectId.from_time(Time.utc(2013, 6, 30)), relative: 'end'},
                      {_id: BSON::ObjectId.from_time(Time.utc(2013, 7, 1)), relative: 'after'}])

puts 'All records'
id_times.find.each do | doc |
  puts doc['relative']
end

puts 'Records in June-2013'
jun_id = BSON::ObjectId.from_time(Time.utc(2013, 6, 1))
jul_id = BSON::ObjectId.from_time(Time.utc(2013, 7, 1))
id_times.find(_id: {'$gte' => jun_id, '$lt' => jul_id}).each do | doc |
  puts doc['relative']
end
