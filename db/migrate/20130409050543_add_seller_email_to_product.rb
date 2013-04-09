class AddSellerEmailToProduct < ActiveRecord::Migration
  def change
    add_column :products, :seller_email, :string
  end
end
