Luaua.Views.Products ||= {}

class Luaua.Views.Products.NewView extends Backbone.View
  template: JST["backbone/templates/products/new"]

  events:
    "submit #new-product": "save"

  initialize: (options) ->
    @product = options.product

    @product.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @product.unset("errors")

    #@collection.create(@product.toJSON(),
    @product.save(
      @product.toJSON(),
      success: (product) =>
        @product = product
        window.location.hash = "/#{@product.id}"

      error: (products, jqXHR) =>
        @product.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@product.toJSON()))
    this.$("form").backboneLink(@product)

    filepicker.setKey('A52AbeLP1S6uDTUT00RBNz')
    featherEditor = new Aviary.Feather(
      apiKey: 'd6671c0d5'
      apiVersion: 2
      appendTo: ""
      cropPresets: ["4:3"]
      fileFormat: "png"
      onSave: (imageID, newURL) =>
        featherEditor.close()
        $image = $("<img src='"+newURL+"' />").hide()
        $editImage = $("<div class='edit-image'><a href='#'>Cambiar imagen</a></div>")
        @product.set({ remote_image_url: newURL })
        @.$(".empty-image").fadeOut 500, =>
          @.$(".empty-image").remove()
          $editImage.appendTo(@.$(".image"))
          $image.appendTo(@.$(".image")).fadeIn 1000
      onError: (errorobj) ->
        console.log errorobj
    )

    $(".empty-image").live "click", ->
      filepicker.getFile(
        filepicker.MIMETYPES.IMAGES, 
        {
          'modal': true,
          'services': ['My Computer', 'Facebook', 'Images', 'URL', 'Webcam', 'Gmail', 'Dropbox']
        },
        (url, token, data) ->
          img = $('<img id="#editimage"/>')
          img.attr("src", url)
          featherEditor.launch({
            image: img[0],
            url: url
          })
      )
      return false
    @
