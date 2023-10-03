# frozen_string_literal: true

class Coupon < ApplicationRecord
  validates :name, presence: true
  validates :discount, presence: true
  validates :count, presence: true, numericality: { greater_than: 0 }

  enum discount: { 九折: 1, 八折: 2, 七折: 3, 五折: 4, 折抵100元: 5, 折抵200元: 6, 折抵300元: 7 }

  belongs_to :order, optional: true
  has_many :users, through: :user_coupons, dependent: :destroy
  has_many :user_coupons
end
