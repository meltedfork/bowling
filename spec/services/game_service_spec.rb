require "rails_helper"

RSpec.describe GameService do
  let(:game_service) { GameService.new } # current_frame = 1, current_roll = 1, score = 0, active_turn

  describe "roll" do
    let(:first_pins_down) { 5 }
    let(:second_pins_down) { 2 }

    it "adds pins_down to current_roll" do
      game_service.roll(first_pins_down)

      active_turn = Frame.find_by(frame_number: 1).rolls.first

      expect(active_turn.roll_number).to eq(1)
      expect(active_turn.pins_down).to eq(5)


      # active_turn.pins_down  = game_service.roll(second_pins_down)
      # expect(current_roll.roll_number).to eq(2)
      # expect(current_roll.pins_down).to eq(2)
    end

    context "when rolls spare" do
      let(:second_pins_down) { 5 }

      it "checks for spare bonus" do
        game_service.roll(first_pins_down)
        game_rolls = game_service.roll(second_pins_down)

        expect(game_rolls).to eq({1=>[5, 5]})
        expect(game_service.check_for_bonus).to eq("spare")
      end
    end

    context "when rolls strike" do
      let(:first_pins_down) { 10 }

      it "checks for strike bonus" do
        game_rolls = game_service.roll(first_pins_down)

        expect(game_rolls).to eq({1=>[10]})
        expect(game_service.check_for_bonus).to eq("strike")
      end
    end

    context "when no bonus roll is earned" do
      it "sets bonus to false" do
        game_rolls = game_service.roll(first_pins_down)
        game_rolls = game_service.roll(second_pins_down)

         expect(game_rolls).to eq({1=>[5, 2]})
         expect(game_service.check_for_bonus).to eq(false)
      end
    end
  end

  describe "spare_bonus" do
    let(:game_rolls) {1=>[8, 2]}

    it "calculates the bonus roll to add to score" do

    end
  end
end
