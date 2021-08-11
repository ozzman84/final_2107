class Auction
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map(&:name)
  end

  def unpopular_items
    @items.find_all do |item|
      item.bid_counter.zero?
    end
  end

  def potential_revenue
    revenue = []
    @items.filter_map do |item|
      revenue << item.current_high_bid if !item.current_high_bid.nil?
    end
    revenue.sum
  end

  def bidders
    bidders = []
    @items.each do |item|
      bidders << item.all_bidders_names
    end
    bidders.flatten.uniq
  end

  def bidder_total_items(bidder)
    items_list = []
    @items.filter_map do |item|
      # item.bids[:name].each do |bidder|
      items_list << item if item.bids.include?(bidder)

      # require "pry"; binding.pry
      # end
    end.flatten
  end

  def bidder_info
    bidder_info = {}
    # bidders.each do |bidder|
      # bidder_total_items(bidder)
      items.each do |item|
        item.all_bidders.each do |bidder|
        bidder_info[bidder] = {
          budget: bidder.budget,
          items: bidder_total_items(bidder) #<< item
        }
      end
    end
    # items.each do |item|
# require "pry"; binding.pry
    #   item.all_bidders.
    bidder_info
    # end
  end
end
