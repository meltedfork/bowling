require 'rails_helper'

RSpec.describe "frames/edit", type: :view do
  let(:frame) {
    Frame.create!(
      frame_number: 1,
      roll_number: 1,
      pins_down: "MyString"
    )
  }

  before(:each) do
    assign(:frame, frame)
  end

  it "renders the edit frame form" do
    render

    assert_select "form[action=?][method=?]", frame_path(frame), "post" do

      assert_select "input[name=?]", "frame[frame_number]"

      assert_select "input[name=?]", "frame[roll_number]"

      assert_select "input[name=?]", "frame[pins_down]"
    end
  end
end
