require 'rails_helper'

RSpec.describe "frames/index", type: :view do
  before(:each) do
    assign(:frames, [
      Frame.create!(
        frame_number: 2,
        roll_number: 3,
        pins_down: "Pins Down"
      ),
      Frame.create!(
        frame_number: 2,
        roll_number: 3,
        pins_down: "Pins Down"
      )
    ])
  end

  it "renders a list of frames" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Pins Down".to_s), count: 2
  end
end
