class Product < ActiveRecord::Base
	require 'carrierwave/orm/activerecord'

  attr_accessible :description, :location, :name, :price, :seller, :image, :remote_image_url

  mount_uploader :image, ImageUploader
end
