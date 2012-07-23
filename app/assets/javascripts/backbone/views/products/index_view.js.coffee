Luaua.Views.Products ||= {}

class Luaua.Views.Products.IndexView extends Backbone.View
  template: JST["backbone/templates/products/index"]

  initialize: () ->
    #@options.products.bind('reset', @addAll)

  addAll: () =>
    @options.products.each(@addOne)

  addOne: (products) =>
    view = new Luaua.Views.Products.ProductsView({model : products})
    @$("tbody").append(view.render().el)

  render: =>
    #$(@el).html(@template(products: @options.products.toJSON() ))
    #@addAll()
    $(@el).html(@template())
    @
