categories = ECommerce.new.database['categories']

categories.delete_many({})

categories.insert_many(
    [
        {
            slug: 'home',
            name: 'Home'
        },
        {
            slug: 'outdoors',
            name: 'Outdoors'
        },
        {
            slug: 'gardening-tools',
            name: 'Gardening Tools',
            description: 'Gardening gadgets galore!',
        }
    ]
)

outdoors_category = categories.find({slug: 'outdoors'}).to_a[0]
categories.update_one(
    {slug: 'gardening-tools'},
    {'$set' => {parent_id: outdoors_category['_id']}}
)

home_category = categories.find({slug: 'home'}).to_a[0]
categories.update_one(
    {slug: 'gardening-tools'},
    {
        '$set' => {
            ancestors: [
                {
                    name: home_category['name'],
                    _id: home_category['_id'],
                    slug: home_category['slug']
                },
                {
                    name: outdoors_category['name'],
                    _id: outdoors_category['_id'],
                    slug: outdoors_category['slug']
                }
            ]
        }
    }
)

categories.find({}).each do |doc|
  p doc
end

