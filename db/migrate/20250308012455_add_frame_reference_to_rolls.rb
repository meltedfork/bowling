class AddFrameReferenceToRolls < ActiveRecord::Migration[7.1]
  def change
    add_reference :rolls, :frame, foreign_key: true
  end
end
