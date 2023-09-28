require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it "每個 Cart Item 都可以計算它⾃⼰的⾦額（⼩計）" do
    b1 = Book.create(name:"Ruby", price: 80)
    b2 = Book.create(name:"Rails", price: 200)

    cart = Cart.new
    3.times { cart.add_item(b1.id) }
    4.times { cart.add_item(b2.id) } 
    2.times { cart.add_item(b1.id) } 
    
    expect(cart.items.first.price).to be 400
    expect(cart.items.second.price).to be 800 
  end
end
