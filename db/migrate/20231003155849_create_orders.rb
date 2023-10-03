class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :amount
      t.string :status
      t.integer :coupon_id
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
