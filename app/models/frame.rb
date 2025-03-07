class Frame < ApplicationRecord
  #TODO: plan for additional models - Games, Players
  attr_accessor :frame_number, :roll_number, :pins_down

  validates :frame_number, numericality: { in: 1..10 }
  validates :roll_number, numericality: { in: 1..3 }

end
