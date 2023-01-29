class GildedRose

  def initialize
    @items= []
  end

  def show_items
    @items
  end

  def add(item)
    @items<< item
  end

  def update_quality()
    @items.each do |item|
      case 
      when item_eq_backstage_passes?(item)
        item_eq_backstage_passes_result(item)
      when item_eq_sulfuras?(item)
        item_eq_sulfuras_result(item)
      when item_eq_aged_brie?(item)
        item_eq_aged_brie_result(item)
      when quality_eq_zero?(item)
        quality_eq_zero_result(item)
      when expired_item?(item)
          expired_item_result(item)
      else
          item.quality -= 1
          item.sell_in -= 1
      end
    end
  end

  def item_eq_backstage_passes?(item)
    item.name == 'Backstage passes to a TAFKAL80ETC concert'
  end

  def item_eq_backstage_passes_result(item)
    if item.sell_in <= 0
      item.quality = 0
      item.sell_in -= 1
    elsif  item.sell_in <= 5
      item.quality += 3
      item.sell_in -= 1
    elsif item.sell_in <= 10
      item.quality += 2
      item.sell_in -= 1
    end
  end


  def item_eq_sulfuras?(item)
    item.name == 'Sulfuras, Hand of Ragnaros'
  end

  def item_eq_sulfuras_result(item)
    item.quality = 80
    item.sell_in += 0
  end

  def item_eq_aged_brie?(item)
    item.name == 'Aged Brie'
  end

  def item_eq_aged_brie_result(item)
    if item.quality < 50
    item.quality += 1
    item.sell_in -= 1
    else
      item.sell_in -= 1
    end
  end

  def quality_eq_zero?(item)
    item.quality <= 0
  end

  def quality_eq_zero_result(item)
    item.quality = 0
    item.sell_in -= 1
  end

  def expired_item?(item)
      item.sell_in <= 0
  end

  def expired_item_result(item)
    item.quality -= 2
    item.sell_in -= 1
  end

  def default_update_quality()
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end

  private 


end