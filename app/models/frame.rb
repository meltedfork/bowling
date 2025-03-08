class Frame < ApplicationRecord
  has_many :rolls

  validates :frame_number, presence: true, numericality: { in: 1..10 }
  validates :score, numericality: { in: 0..300 }

end
