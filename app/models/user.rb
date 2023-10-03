# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :orders
  has_many :coupons, through: :user_coupons, dependent: :destroy
  has_many :user_coupons
end
