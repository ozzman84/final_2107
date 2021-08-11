require './lib/item'
#=> true
require './lib/auction'
#=> true
require './lib/attendee'


RSpec.describe Auction do
  it 'exists & has attributes' do
    auction = Auction.new#=> #<Auction:0x00007fbda90f1cc0 @items=[]>

    expect(@auction.items).to eq([])
  end

  before :each do
    @attendee = Attendee.new(name: 'Megan', budget: '$50')#=> #<Attendee:0x00007fbda913f038 @budget=50, @name="Megan">
    @auction = Auction.new#=> #<Auction:0x00007fbda90f1cc0 @items=[]>
    @item1 = Item.new('Chalkware Piggy Bank')#=> #<Item:0x00007fbda98fa1b0 @bids={}, @name="Chalkware Piggy Bank">
    @item2 = Item.new('Bamboo Picture Frame')#=> #<Item:0x00007fbda91874f0 @bids={}, @name="Bamboo Picture Frame">
    @item3 = Item.new('Homemade Chocolate Chip Cookies')#=> #<Item:0x00007fdc071ab040 @bids={}, @name="Homemade Chocolate Chip Cookies">
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')
    @attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    @attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    @attendee3 = Attendee.new(name: 'Mike', budget: '$100')
  end

  it 'returns items and their names' do
    @auction.add_item(@item1)
    @auction.add_item(@item2)

    expect(@auction.items).to eq([@item1, @item2])
    expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
  end

  describe 'add objects' do
    before :each do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
    end

    it 'returns bids & current_high_bid' do
      expect(@item1.bids).to eq({})

      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)

      expect(@item1.bids).to eq({
        @attendee2 => 20,
        @attendee1 => 22
      })

      expect(@item1.current_high_bid).to eq(22)
    end

    it 'returns unpopular_items' do
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)

      expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])

      @item3.add_bid(@attendee2, 15)

      expect(@auction.unpopular_items).to eq([@item2, @item5])
    end

    it 'returns potential_revenue' do
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)

      expect(@auction.potential_revenue).to eq(87)
    end

    describe 'add bids' do
      before :each do
        @item1.add_bid(@attendee1, 22)
        @item1.add_bid(@attendee2, 20)
        @item4.add_bid(@attendee3, 50)
        @item3.add_bid(@attendee2, 15)
      end

      it 'returns bidders & their info' do
        expect(@auction.bidders).to eq(["Megan", "Bob", "Mike"])

        expect(@auction.bidder_info).to eq({
          @attendee1 =>
            {
              :budget => 50,
              :items => [@item1]
            },
          @attendee2 =>
            {
              :budget => 75,
              :items => [@item1, @item3]
            },
          @attendee3 =>
            {
              :budget => 100,
              :items => [@item4]
            }
         })
       end

      xit 'returns bids and closes bids' do
        expect(@item1.bids).to eq({@attendee1 => 22, @attendee2 => 20})

        @item1.close_bidding

        @item1.add_bid(@attendee3, 70)

        expect(@item1.bids).to eq({@attendee1 => 22, @attendee2 => 20})
      end
    end
  end
end
