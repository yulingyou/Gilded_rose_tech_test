require 'gilded_rose'
require 'item'

RSpec.describe GildedRose do
  it "" do
    gilded_rose = GildedRose.new
    expect(gilded_rose.show_items).to eq([])  
  end
end