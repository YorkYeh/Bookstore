require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "購物⾞基本功能" do
    it "可以把商品丟到到購物⾞裡，然後購物⾞裡就有東⻄了" do
      cart = Cart.new
      cart.add_item 1 
      expect(cart.empty?).to be false  
    end

    it "如果加了相同種類的商品到購物⾞裡，購買項⽬（CartItem）並不會增加，但商品的數量會改變" do
      cart = Cart.new
      3.times { cart.add_item(1) }
      5.times { cart.add_item(2) }
      2.times { cart.add_item(3) }

      expect(cart.items.length).to be 3 
      expect(cart.items.first.quantity).to be 3
      expect(cart.items.second.quantity).to be 5
    end


    it "商品可以放到購物⾞裡，也可以再拿出來" do  
      cart = Cart.new
      b1 = Book.create(name:"Ruby", price:"100")
      b2 = Book.create(name:"Rails", price:"200")

      4.times { cart.add_item(b1.id) }
      2.times { cart.add_item(b2.id) }

      expect(cart.items.first.book_id).to be b1.id 
      expect(cart.items.second.book_id).to be b2.id 
      expect(cart.items.first.book).to be_a Book
    end

    it "可以計算整台購物⾞的總消費⾦額" do
      cart = Cart.new
      b1 = Book.create(name:"Ruby", price: 80)
      b2 = Book.create(name:"Rails", price: 200)

      3.times {
        cart.add_item(b1.id)
        cart.add_item(b2.id)
      }

      expect(cart.total_price).to be 840
    end
    # it "特別活動可能可搭配折扣（例如聖誕節的時候全⾯打 9 折，或是滿額滿千送
    # 百）"
  end

  describe "購物⾞進階功能" do
    it "可以將購物⾞內容轉換成 Hash，存到 Session 裡" do
      cart = Cart.new
      3.times { cart.add_item(2) } 
      4.times { cart.add_item(5) }

      expect(cart.serialize).to eq session_hash
    end
    it "可以把 Session 的內容（Hash 格式），還原成購物⾞的內容" do
      cart = Cart.from_hash(session_hash)
      expect(cart.items.first.book_id).to be 2
      expect(cart.items.first.quantity).to be 3
      expect(cart.items.second.book_id).to be 5
      expect(cart.items.second.quantity).to be 4
    end
  end

  private

  def session_hash
    {
      "items" => [
        {"book_id" => 2, "quantity" => 3},
        {"book_id" => 5, "quantity" => 4}
      ]
    }
  end

end    
