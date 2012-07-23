class Product < ActiveRecord::Base
  attr_accessible :description, :location, :name, :price, :seller
end
