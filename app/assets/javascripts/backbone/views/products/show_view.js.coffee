Luaua.Views.Products ||= {}

class Luaua.Views.Products.ShowView extends Backbone.View
  template: JST["backbone/templates/products/show"]

  initialize: (options) ->
  	@product = options.product

  render: ->
    $(@el).html(@template(@product.toJSON() ))
    return this
