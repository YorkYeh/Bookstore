class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :name
      t.datetime :start_time, default: -> { 'now()' }
      t.datetime :expiry_time
      t.integer :discount
      t.integer :count, default: 1
      t.string :status, default: 'preparing'

      t.timestamps
    end
  end
end
