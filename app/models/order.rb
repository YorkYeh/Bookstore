class Order < ApplicationRecord

  belongs_to :user
  has_one :coupon
  has_many :books, through: :book_orders
  has_many :book_orders

end
