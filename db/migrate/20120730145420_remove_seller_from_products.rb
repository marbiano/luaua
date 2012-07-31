class RemoveSellerFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :seller
  end

  def down
    add_column :products, :seller, :string
  end
end
