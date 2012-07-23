class Luaua.Models.Products extends Backbone.Model
  paramRoot: 'product'

  defaults:
    name: null
    price: null
    description: null
    location: null
    seller: null

class Luaua.Collections.ProductsCollection extends Backbone.Collection
  model: Luaua.Models.Products
  url: '/products'
