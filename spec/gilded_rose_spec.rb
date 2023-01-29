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
    expect(result[0].sell_in).to eq(-1)
    expect(result[0].quality).to eq(18)
  end

  it "the quality of an item is never negative" do
    item = Item.new('item1',10,0)
    gilded_rose = GildedRose.new
    gilded_rose.add(item)
    result = gilded_rose.update_quality()
    expect(result[0].sell_in).to eq(9)
    expect(result[0].quality).to eq(0)
  end

  it "should increases in Quality the older it gets if item is 'Aged Brie'" do
    item = Item.new("Aged Brie",10,10)
    gilded_rose = GildedRose.new
    gilded_rose.add(item)
    result = gilded_rose.update_quality()
    expect(result[0].sell_in).to eq(9)
    expect(result[0].quality).to eq(11)
  end

  it "quality of an item is never more than 50" do
    item = Item.new("Aged Brie",10,50)
    gilded_rose = GildedRose.new
    gilded_rose.add(item)
    result = gilded_rose.update_quality()
    expect(result[0].sell_in).to eq(9)
    expect(result[0].quality).to eq(50)
  end

  it "'Sulfuras', being a legendary item, never has to be sold or decreases in Quality" do
    item = Item.new("Sulfuras, Hand of Ragnaros",0,80)
    gilded_rose = GildedRose.new
    gilded_rose.add(item)
    result = gilded_rose.update_quality()
    expect(result[0].sell_in).to eq(0)
    expect(result[0].quality).to eq(80)
  end

  context "Backstage passes" do
    it "'Backstage passes's qauality increases by 2 when there are 10 days or less" do 
      item = Item.new("Backstage passes to a TAFKAL80ETC concert",10,20)
      gilded_rose = GildedRose.new
      gilded_rose.add(item)
      result = gilded_rose.default_update_quality()
      expect(result[0].sell_in).to eq(9)
      expect(result[0].quality).to eq(22)
    end

    it "'Backstage passes's aquality increases by 3 when there are 5 days or less" do 
      item = Item.new("Backstage passes to a TAFKAL80ETC concert",5,20)
      gilded_rose = GildedRose.new
      gilded_rose.add(item)
      result = gilded_rose.default_update_quality()
      expect(result[0].sell_in).to eq(4)
      expect(result[0].quality).to eq(23)
    end

    it "'Backstage passes's aquality drops to 0 after the concert" do 
      item = Item.new("Backstage passes to a TAFKAL80ETC concert",0,20)
      gilded_rose = GildedRose.new
      gilded_rose.add(item)
      result = gilded_rose.default_update_quality()
      expect(result[0].sell_in).to eq(-1)
      expect(result[0].quality).to eq(0)
    end
  end
end