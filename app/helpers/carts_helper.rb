# frozen_string_literal: true

module CartsHelper
  def current_cart
    @current_cart ||= Cart.from_hash(session[:cart9487])
  end
end
