class Luaua.Models.User extends Backbone.Model
  paramRoot: 'user'

  defaults:
    email: null
    password: null

class Luaua.Collections.UsersCollection extends Backbone.Collection
  model: Luaua.Models.User
  url: '/users'
