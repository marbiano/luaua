class Luaua.Routers.ProductsRouter extends Backbone.Router
  initialize: (options) ->
    @products = new Luaua.Collections.ProductsCollection()
    #@products.reset options.products

  routes:
    "/new"      : "new"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"


  index: ->
    #@view = new Luaua.Views.Products.IndexView(products: @products)
    #$("#products").html(@view.render().el)
    @view = new Luaua.Views.Products.IndexView()
    $(".main").fadeOut 500, =>
      $(".main").html(@view.render().el).fadeIn 500

  new: ->
    @view = new Luaua.Views.Products.NewView({ product : new Luaua.Models.Product })
    $(".main").fadeOut 500, =>
      $(".main").html(@view.render().el).fadeIn 500, ->
        $(".field input").jLabel()
        $(".field textarea").jLabel({yShift: 3})

  show: (id) ->
    product = new Luaua.Models.Product({ id : id })
    product.fetch(
      success: (model, response) =>
        @view = new Luaua.Views.Products.ShowView({ product : model })
        $(".main").fadeOut 500, =>
          $(".main").html(@view.render().el).fadeIn 500
    )

  edit: (id) ->
    products = @products.get(id)

    @view = new Luaua.Views.Products.EditView(model: products)
    $("#products").html(@view.render().el)
