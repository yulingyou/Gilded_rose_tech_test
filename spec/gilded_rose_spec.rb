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

  it "the quality should decrease 1 after end of the day" do
    item = Item.new('item1',10,20)
    gilded_rose = GildedRose.new
    gilded_rose.add(item)
    result = gilded_rose.update_quality()
    expect(result[0].quality).to eq(19)
  end

  it "the sell_in should decrease 1 after end of the day" do
    item = Item.new('item1',10,20)
    gilded_rose = GildedRose.new
    gilded_rose.add(item)
    result = gilded_rose.update_quality()
    expect(result[0].sell_in).to eq(9)
  end

  it "once the sell by date has passed, quality degrades twice as fast" do
    item = Item.new('item1',0,20)
    gilded_rose = GildedRose.new
    gilded_rose.add(item)
    result = gilded_rose.update_quality()
    expect(result[0].quality).to eq(18)
  end

  it "the quality of an item is never negative" do
    item = Item.new('item1',10,0)
    gilded_rose = GildedRose.new
    gilded_rose.add(item)
    result = gilded_rose.update_quality()
    expect(result[0].quality).to eq(0)
  end
end