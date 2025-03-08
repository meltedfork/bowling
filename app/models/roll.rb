class Roll < ApplicationRecord
  belongs_to :frame

  validates :roll_number, presence: true, numericality: { in: 1..3 }
  validates :pins_down, presence: true, numericality: { in: 0..10 }
  validates :kind, inclusion: { in: %w(regular spare strike) }

end
