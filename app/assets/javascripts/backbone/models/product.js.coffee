class Luaua.Models.Product extends Backbone.Model
  urlRoot: '/products'

  defaults:
    name: null
    price: null
    description: null
    location: null
    seller: null
    image: null
    remote_image_url: null

class Luaua.Collections.ProductsCollection extends Backbone.Collection
  model: Luaua.Models.Product
  url: '/products'
