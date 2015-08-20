class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.float :price
      t.text :description

      t.timestamps
    end
  end
end
