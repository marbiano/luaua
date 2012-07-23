class Luaua.Routers.ProductsRouter extends Backbone.Router
  initialize: (options) ->
    @products = new Luaua.Collections.ProductsCollection()
    #@products.reset options.products

  routes:
    "new"      : "newProducts"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newProducts: ->
    @view = new Luaua.Views.Products.NewView(collection: @products)
    $("#main").fadeOut 500, =>
      $("#main").html(@view.render().el).fadeIn 500, ->
        $(".field input").jLabel()
        $(".field textarea").jLabel({yShift: 3})

  index: ->
    #@view = new Luaua.Views.Products.IndexView(products: @products)
    #$("#products").html(@view.render().el)
    @view = new Luaua.Views.Products.IndexView()
    $("#main").html(@view.render().el)

  show: (id) ->
    products = @products.get(id)

    @view = new Luaua.Views.Products.ShowView(model: products)
    $("#products").html(@view.render().el)

  edit: (id) ->
    products = @products.get(id)

    @view = new Luaua.Views.Products.EditView(model: products)
    $("#products").html(@view.render().el)
