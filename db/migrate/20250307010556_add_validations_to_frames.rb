class AddValidationsToFrames < ActiveRecord::Migration[7.1]
  def change
    change_column_null :frames, :frame_number, false
    change_column_null :frames, :roll_number, false
    change_column_null :frames, :pins_down, false
  end
end
