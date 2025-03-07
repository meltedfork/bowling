class CreateFrames < ActiveRecord::Migration[7.1]
  def change
    create_table :frames do |t|
      t.integer :frame_number
      t.integer :roll_number
      t.string :pins_down

      t.timestamps
    end
  end
end
