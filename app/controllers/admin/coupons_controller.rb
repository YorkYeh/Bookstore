# frozen_string_literal: true

module Admin
  class CouponsController < ApplicationController
    def index
      @coupons = Coupon.all
    end

    def new
      @coupon = Coupon.new
    end

    def create
      @coupon = Coupon.new(coupon_params)
      if @coupon.save
        redirect_to admin_coupons_path, notice: '折價券已成功新增'
      else
        render :new
      end
    end

    def destroy
      @coupon = Coupon.find(params[:id])
      @coupon.destroy
      redirect_to admin_coupons_path, alert: '刪除成功'
    end

    private

    def coupon_params
      params.require(:coupon).permit(:name, :start_time, :expiry_time, :discount, :count, :status)
    end
  end
end
