Luaua.Views.Products ||= {}

class Luaua.Views.Products.ProductsView extends Backbone.View
  template: JST["backbone/templates/products/products"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
