require './lib/item'
require './lib/attendee'


RSpec.describe Attendee do
  it 'exists & has attributes' do
  @attendee = Attendee.new(name: 'Megan', budget: '$50')
  #=> #<Attendee:0x00007fbda913f038 @budget=50, @name="Megan">

  expect(@attendee.name).to eq("Megan")
  expect(@attendee.budget).to eq(50)
  end
end
