require 'rails_helper'

RSpec.describe "frames/new", type: :view do
  before(:each) do
    assign(:frame, Frame.new(
      frame_number: 1,
      roll_number: 1,
      pins_down: "MyString"
    ))
  end

  it "renders new frame form" do
    render

    assert_select "form[action=?][method=?]", frames_path, "post" do

      assert_select "input[name=?]", "frame[frame_number]"

      assert_select "input[name=?]", "frame[roll_number]"

      assert_select "input[name=?]", "frame[pins_down]"
    end
  end
end
