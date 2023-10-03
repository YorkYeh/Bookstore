class CreateBookOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :book_orders do |t|
      t.belongs_to :book, null: false, foreign_key: true
      t.belongs_to :order, null: false, foreign_key: true
      t.integer :book_quantity, default: 1

      t.timestamps
    end
  end
end
