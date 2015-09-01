class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.boolean :status, default: false
      t.string :coupon
      t.integer :discount_percentage

      t.timestamps
    end
  end
end
