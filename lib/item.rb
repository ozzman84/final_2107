class Item
  attr_reader :name,
              :bids,
              :bid_counter

  def initialize(name)
    @name = name
    @bids = Hash.new(0)
    @bid_counter = 0
  end

  def add_bid(attendee, bid)
    @bids[attendee] += bid
    @bid_counter += 1
  end

  def current_high_bid
    bids = []
    @bids.map do |attendee, bid|
      bids << bid
    end
    bids.sort.last
  end

  def all_bidders_names
    @bids.keys.flat_map(&:name)
  end

  def all_bidders
    @bids.keys.flat_map do |bidder|
      bidder
    end
  end
end
