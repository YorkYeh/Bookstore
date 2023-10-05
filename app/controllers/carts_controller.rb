# frozen_string_literal: true

class CartsController < ApplicationController
  def add
    if current_user
      current_cart.add_item(params[:id])
      session[:cart9487] = current_cart.serialize
      redirect_to books_path, notice: '已加入購物車'
    else
      flash[:notice] = '請先登入會員'
      redirect_to new_user_session_path
    end
  end

  def destroy
    session[:cart9487] = nil
    redirect_to books_path, notice: '購物車已清空'
  end
end
