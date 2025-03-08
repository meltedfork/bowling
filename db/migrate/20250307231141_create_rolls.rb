class CreateRolls < ActiveRecord::Migration[7.1]
  def change
    create_table :rolls do |t|
      t.integer :roll_number
      t.integer :pins_down
      t.string :kind
      t.boolean :bonus

      t.timestamps
    end
  end
end
