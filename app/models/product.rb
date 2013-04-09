class Product < ActiveRecord::Base
require 'carrierwave/orm/activerecord'
  attr_accessor :seller_email
  attr_accessible :description, :location, :name, :price, :seller_email, :seller_id, :image, :remote_image_url

  mount_uploader :image, ImageUploader

  validates :name, :presence => { :message => "Tu aviso necesita un titulo." }
 # validates :price, :numericality => { :message => "Tu aviso necesita un precio numerico." }
 # validates :description, :presence => { :message => "Tu aviso necesita una breve descripcion." }
 # validates :location, :presence => { :message => "Tu aviso necesita una ubicacion." }
 # validates :remote_image_url, :presence => { :message => "Tu aviso necesita una imagen." }
 # validates :seller_email, :email_format => { :message => "Tu aviso necesita un email del vendedor." }
  
  belongs_to :user
  #belongs_to :seller, :class_name => "User", :foreign_key => "seller_id"

  def as_json(options={})
  	super(:include => :seller)
  end
end
