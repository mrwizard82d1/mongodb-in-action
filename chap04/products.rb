products = ECommerce.new.database['products']

# Remove all documents....
products.delete_many({})

# ...and add them again
products.insert_one(
    {
        slug: 'wheelbarrow-9029',
        sku: '9029',
        name: 'Extra Large Wheelbarrow',
        description: 'Heavy duty wheelbarrow...',
        details: {
            weight: 47,
            weight_units: 'lbs',
            model_num: 4039283402,
            manufacturer: 'Acme',
            color: 'Green'
        },
        total_reviews: 4,
        average_review: 4.5,
        pricing: {
            retail: 529700,
            sale: 429700,
        },
        price_history: [
            {
                retail: 529700,
                sale: 429700,
                start: Date.new(2018, 1, 1),
                end: Date.new(2018, 1, 8)
            },
            {
                retail: 529700,
                sale: 529700,
                start: Date.new(2018, 1, 9),
                end: Date.new(2018, 1, 16)
            }
        ],
        tags: %w(tools gardening soil)
    }
)

products.indexes.create_one({slug: 1}, unique: true)

categories = ECommerce.new.database['categories']
categories.find({slug: 'gardening-tools'}).each do | category |
  products.update_one(
      {slug: 'wheelbarrow-9029'},
      {'$set' => {primary_category: category['_id']}}
  )
  products.update_one(
      {slug: 'wheelbarrow-9029'},
      {'$set' =>
           {
               category_ids: [category['_id']]
           }
      }
  )
  products.update_one(
      {slug: 'wheelbarrow-9029'},
      {'$set' => {main_cat_id: category['_id']}}
  )
end

products.find({}).each do | doc |
  p doc
end
