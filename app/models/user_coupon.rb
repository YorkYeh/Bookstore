# frozen_string_literal: true

class UserCoupon < ApplicationRecord
  belongs_to :user
  belongs_to :coupon
end
