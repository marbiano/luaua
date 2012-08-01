Luaua.Views.Products ||= {}

class Luaua.Views.Products.AboutView extends Backbone.View
  template: JST["backbone/templates/products/about"]

  render: =>
    $(@el).html(@template())
    @
