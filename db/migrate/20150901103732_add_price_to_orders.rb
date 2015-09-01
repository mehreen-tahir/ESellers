class AddPriceToOrders < ActiveRecord::Migration
  def change
   add_column :orders, :orignal_price,    :integer, default: 0
   add_column :orders, :discounted_price, :integer, default: 0
   add_column :orders, :is_discounted,    :boolean, default: false
  end
end
