Luaua.Views.Products ||= {}

class Luaua.Views.Products.NewView extends Backbone.View
  template: JST["backbone/templates/products/new"]

  events:
    "submit #new-product": "save"

  initialize: (options) ->
    _.bindAll(@, 'render', 'save', 'render_errors', 'limit_field')
    @product = options.product

    @description_max_chars = 200

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @product.unset("errors")

    $('<div class="loading"><span>Publicando tu aviso. Un segundo...</span></div>').hide().appendTo($("body")).fadeIn 250

    #@collection.create(@product.toJSON(),
    @product.save(
      @product.toJSON(),
      success: (product) =>
        window.location.hash = "/#{product.id}"

      error: (product, jqXHR) =>
        $(".loading").fadeOut 500, =>
          $(".loading").remove()
        @product.set({errors: $.parseJSON(jqXHR.responseText)})
        @render_errors()
    )

  render: ->
    $(@el).html(@template(@product.toJSON()))
    this.$("form").backboneLink(@product)

    filepicker.setKey('A52AbeLP1S6uDTUT00RBNz')
    #featherEditor = new Aviary.Feather(
    #  apiKey: 'd6671c0d5'
    #  apiVersion: 2
    #  appendTo: ""
    #  cropPresets: ["4:3"]
    #  fileFormat: "png"
    #  onSave: (imageID, newURL) =>
    #    featherEditor.close()
    #    $image = $("<img src='"+newURL+"' />")
    #    @product.set({ remote_image_url: newURL })
    #    if @.$(".empty-image").length > 0
    #      $editImage = $("<div class='edit-image'><a href='#'>Cambiar imagen</a></div>")
    #      @.$(".image").fadeOut 500, =>
    #        @.$(".empty-image").remove()
    #        $image.appendTo(@.$(".image"))
    #        @.$(".image").fadeIn 1000, =>
    #          $editImage.appendTo(@.$(".image"))
    #    else
    #      @.$(".image").fadeOut 500, =>
    #        @.$(".image img").remove()
    #        $image.appendTo(@.$(".image"))
    #        @.$(".image").fadeIn 1000
    #  onError: (errorobj) ->
    #    console.log errorobj
    #)

    $(".empty-image, .edit-image").live "click", =>
      filepicker.getFile(
        filepicker.MIMETYPES.IMAGES, 
        {
          'modal': true,
          'services': ['My Computer', 'Facebook', 'Images', 'URL', 'Webcam', 'Gmail', 'Dropbox']
        },
        (newURL, token, data) =>
          #img = $('<img id="#editimage"/>')
          #img.attr("src", newURL)
          #featherEditor.launch({
          #  image: img[0],
          #  url: newURL
          #})
          $image = $("<img src='"+newURL+"' />")
          @product.set({ remote_image_url: newURL })
          if @.$(".empty-image").length > 0
            $editImage = $("<div class='edit-image'><a href='#'>Cambiar imagen</a></div>")
            @.$(".image").fadeOut 500, =>
              @.$(".empty-image").remove()
              $image.appendTo(@.$(".image"))
              @.$(".image").fadeIn 1000, =>
                $editImage.appendTo(@.$(".image"))
          else
            @.$(".image").fadeOut 500, =>
              @.$(".image img").remove()
              $image.appendTo(@.$(".image"))
              @.$(".image").fadeIn 1000
      )
      return false

    @.$(".field_with_errors input, .field_with_errors textarea").live "focus", (e) => 
      $(e.target).parent().find('span.field-error').fadeIn 500
      $(e.target).parent().addClass("field_being_fixed")
    
    @.$(".field_with_errors input, .field_with_errors textarea").live "blur", (e) =>
      $(e.target).parent().removeClass("field_being_fixed")
      if $(e.target).val() != ""
        $(e.target).parent().removeClass("field_with_errors")  
      $(e.target).parent().find('span.field-error').fadeOut 100


    @.$(".char-count").text(@description_max_chars)

    @.$("textarea#description").live 'keyup', =>
      @limit_field(@.$("textarea#description"), @.$(".char-count"), @description_max_chars)

    @.$("textarea#description").live 'keydown', =>
      @limit_field(@.$("textarea#description"), @.$(".char-count"), @description_max_chars)

    @

  render_errors: ->
    @.$('span.field-error').hide().remove()
    @.$(".field_with_errors").toggleClass('field_with_errors')
   
    _.each(@product.get('errors'), (errs, field) =>
      txt = errs.join(", ")
      if field == "remote_image_url"
        @.$(".empty-image").addClass("field_with_errors")
        $('<span class="field-error">' + txt + '</span>').hide().appendTo(@.$(".empty-image")).fadeIn 500
      else
        $parent = @.$('#' + field).parent()
        $parent.addClass("field_with_errors")
        $ $('<span class="field-error">' + txt + '</span>').hide().appendTo($parent)
    )


  limit_field: (field, counter, max) ->
    if field.val().length > max
      field.val(field.val().substring(0, max))
    counter.text(max - field.val().length)
    @product.set({description: field.val()})