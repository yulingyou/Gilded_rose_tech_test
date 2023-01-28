require 'gilded_rose'
require 'item'

RSpec.describe GildedRose do
  it "should show [] if no item added" do
    gilded_rose = GildedRose.new
    expect(gilded_rose.show_items).to eq([])  
  end

  it "should show item1 if item1 added" do
    item = Item.new('item1',10,20)
    gilded_rose = GildedRose.new
    gilded_rose.add(item)
    expect(gilded_rose.show_items).to eq([item])  
  end
end