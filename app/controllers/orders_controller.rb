# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @order = current_user.orders.find_by(status: 'pended')
    order_information = @order.books.group(:name, :id, :price).count

    @current_order = order_information.map do |element|
      book, count = element
      { name: book.first, id: book.second, price: book.last, count: }
    end

    @books = @order.books
    @coupons = Coupon.all
    @client_token = Braintree::ClientToken.generate
  end

  def checkout
    @order = current_user.orders.find(params[:id])
    nonce = params[:payment_method_nonce]
    result = Braintree::Transaction.sale(amount: @order.amount, payment_method_nonce: nonce)

    redirect_to books_path, notice: '刷卡成功' if result
  end

  private

  def orders_params
    params.require(:order).permit(:amount, :coupon_id, :user_id)
  end
end
