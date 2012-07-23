Luaua.Views.Products ||= {}

class Luaua.Views.Products.NewView extends Backbone.View
  template: JST["backbone/templates/products/new"]

  events:
    "submit #new-products": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (products) =>
        @model = products
        window.location.hash = "/#{@model.id}"

      error: (products, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON()))
    this.$("form").backboneLink(@model)
    return this
