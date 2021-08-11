require './lib/item'

RSpec.describe Item do
  it 'exists & has attributes' do
    @item1 = Item.new('Chalkware Piggy Bank')#=> #<Item:0x00007fbda98fa1b0 @bids={}, @name="Chalkware Piggy Bank">
    expect(@item1.name).to eq("Chalkware Piggy Bank")
  end
end
