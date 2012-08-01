Luaua.Views.Products ||= {}

class Luaua.Views.Products.ShowView extends Backbone.View
	template: JST["backbone/templates/products/show"]

	events:
		'click .share-twitter' : 'share_twitter'
		'click .share-facebook' : 'share_facebook'

	initialize: (options) ->
		@product = options.product

	render: ->
		$(@el).html(@template(@product.toJSON() ))
		
		email_link = "mailto:email@email.com?subject="+encodeURIComponent(@product.get("name"))+" en venta&body="+encodeURIComponent(@product.get("description"))+"%0A%0A"+window.location
		@.$(".share-email").attr("href", email_link)

		if !@product.get('seller')?
			@.$('.seller').remove()
		@

	share_twitter: (e) ->
		width = 575
		height = 400
		left = ($(window).width()  - width)  / 2
		top = ($(window).height() - height) / 2
		product_url = window.location
		url = $(e.target).attr('href') + "?url="+encodeURIComponent(product_url)+"&text="+encodeURIComponent(@product.get("name"))+" en venta:"
		opts = 'status=1'+',width='+width+',height='+height+',top='+top+',left='+left
		window.open(url, 'twitter', opts);
		return false


	share_facebook: (e) ->
		width = 660
		height = 400
		left = ($(window).width()  - width)  / 2
		top = ($(window).height() - height) / 2
		product_url = window.location
		url = $(e.target).attr('href') + "?s= 100&p[title]="+encodeURIComponent(@product.get("name"))+" en venta&p[url]="+encodeURIComponent(product_url)+"&p[images][0]="+@product.get("image").url+"&p[summary]="+encodeURIComponent(@product.get("description"))
		opts = 'status=1'+',width='+width+',height='+height+',top='+top+',left='+left
		window.open(url, 'facebook', opts);
		return false
