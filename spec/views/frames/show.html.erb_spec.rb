require 'rails_helper'

RSpec.describe "frames/show", type: :view do
  before(:each) do
    assign(:frame, Frame.create!(
      frame_number: 2,
      roll_number: 3,
      pins_down: "Pins Down"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Pins Down/)
  end
end
