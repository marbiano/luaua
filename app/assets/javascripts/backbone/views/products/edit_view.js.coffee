Luaua.Views.Products ||= {}

class Luaua.Views.Products.EditView extends Backbone.View
  template : JST["backbone/templates/products/edit"]

  events :
    "submit #edit-products" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (products) =>
        @model = products
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
