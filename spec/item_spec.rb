require 'item'

RSpec.describe Item do
  it "should return the item detail" do
    item = Item.new('item1', 10, 20)
    result = item.to_s()
    expect(result).to eq("item1, 10, 20")  
  end
end
