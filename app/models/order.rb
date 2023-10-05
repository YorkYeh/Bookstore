# frozen_string_literal: true

class Order < ApplicationRecord
  include AASM

  belongs_to :user
  has_one :coupon
  has_many :book_orders
  has_many :books, through: :book_orders

  aasm column: 'status' do
    state :pended, initial: true
    state :paid

    event :pay do
      transitions from: :pended, to: :paid
    end
  end

  def price_calculation(discount, amount)
    case discount
    when '九折'
      amount * 0.9
    when '八折'
      amount * 0.8
    when '七折'
      amount * 0.7
    when '五折'
      amount * 0.5
    when '折抵100元'
      amount - 100
    when '折抵200元'
      amount - 200
    when '折抵300元'
      amount - 300
    end
  end

  def total_amount(amount)
    [amount, 0].max
  end
end
