# frozen_string_literal: true

module Api
  module V1
    class OrdersController < ApplicationController
      def add_to_cart
        user = User.find(params[:user_id])
        book = Book.find(params[:book_id])
        order = user.orders.find_or_create_by(status: 'pended')
        order.books << book

        coupon = Coupon.find_by(id: order.coupon_id)
        origin_amount = order.books.sum(:price)
        discount_amount = coupon ? order.price_calculation(coupon.discount, origin_amount) : origin_amount
        amount = order.total_amount(discount_amount)
        order.update(amount:)

        render json: {
          message: '成功加入',
          params:,
          amount:
        }
      end

      def remove_to_cart
        order = Order.find(params[:id])
        order.book_orders.find_by(book_id: params[:book_id]).destroy
        coupon = Coupon.find_by(id: order.coupon_id)
        origin_amount = order.books.pluck(:price).sum
        if coupon
          discount_amount = order.price_calculation(coupon.discount, origin_amount)
          amount = order.total_amount(discount_amount)
        else
          amount = origin_amount
        end
        order.update(amount:)

        render json: {
          message: '移除訂單成功！',
          params:,
          amount:
        }
      end

      def select_coupon
        order = Order.find(params[:id])
        coupon = Coupon.find(params[:coupon_id])
        origin_amount = order.books.pluck(:price).sum
        discount_amount = order.price_calculation(coupon.discount, origin_amount)
        amount = order.total_amount(discount_amount)
        order.update(amount:, coupon_id: params[:coupon_id])

        render json: {
          message: '折價卷選擇成功',
          coupon:,
          amount:
        }
      end
    end
  end
end
