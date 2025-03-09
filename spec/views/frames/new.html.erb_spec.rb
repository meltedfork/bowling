require 'rails_helper'

RSpec.describe "frames/new", type: :view do
  before(:each) do
    assign(:frame, Frame.new(
      frame_number: 1,
      score: 2
    ))
  end

  it "renders new frame form" do
    render

    assert_select "form[action=?][method=?]", frames_path, "post" do
      assert_select "input[name=?]", "frame[frame_number]"
      assert_select "input[name=?]", "frame[score]"
    end
  end
end
