class ProductsController < ApplicationController
  #before_filter :authenticate_user!, :except => [:index]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json

  def create
    @product = Product.new(params[:product])
    respond_to do |format|
     if current_user.nil? 
        format.html { redirect_to new_user_session_path, :notice => "Debe loggearse"}
        format.json { render json: @product.errors, status: :unprocessable_entity }
      else
        @product.user_id = current_user.id
        @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      end
     end
  end
  #def create
    #@product = Product.new(params[:product])

    #respond_to do |format|
      #if @product.valid?
        #user = User.where(:email => params[:product][:seller_email])
        #if user.empty?
          #password = Devise.friendly_token.first(6)
          #seller = User.new(:email => params[:product][:seller_email], :password => password, :password_confirmation => password, :active => false)
          #seller.save
        #else
          #seller = user.first
        #end
        #@product.seller_id = seller.id
        #@product.save
        #format.html { redirect_to @product, notice: 'Product was successfully created.' }
        #format.json { render json: @product, status: :created, location: @product }
      #else
        #format.html { render action: "new" }
        #format.json { render json: @product.errors, status: :unprocessable_entity }
      #end
    #end
  #end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def show_all
   @products = current_user.products
   respond_to do |format|

      format.html # show_all.html.erb
      format.json { render json: @products }
    end
  end
end
