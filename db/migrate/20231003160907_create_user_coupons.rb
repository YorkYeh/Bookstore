class CreateUserCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :user_coupons do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :coupon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
