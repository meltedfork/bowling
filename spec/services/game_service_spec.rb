require "rails_helper"

RSpec.describe GameService do
  let(:game_service) { GameService.new }

  describe "roll" do
    let(:first_pins_down) { 5 }
    let(:second_pins_down) { 2 }

    it "adds pins_down to active_turn" do
      game_service.roll(first_pins_down)
      active_turn = game_service.frame.rolls.first

      expect(active_turn.roll_number).to eq(1)
      expect(active_turn.pins_down).to eq(5)

      game_service.roll(second_pins_down)
      active_turn = game_service.frame.rolls.last

      expect(active_turn.roll_number).to eq(2)
      expect(active_turn.pins_down).to eq(2)
    end

    context "check_for_bonus when rolls spare" do
      let(:second_pins_down) { 5 }

      it "assigns a spare bonus" do
        game_service.roll(first_pins_down)
        previous_turn = game_service.frame.rolls.first

        game_service.roll(second_pins_down)
        active_turn = game_service.frame.rolls.last

        expect(active_turn.kind).to eq("spare")
      end
    end

    context "check_for_bonus when rolls strike" do
      let(:first_pins_down) { 10 }

      it "assigns a strike bonus" do
        game_service.roll(first_pins_down)
        active_turn = game_service.frame.rolls.first

        expect(active_turn.pins_down).to eq(10)
        expect(active_turn.kind).to eq("strike")
      end
    end

    context "when no bonus roll is earned" do
      it "sets bonus to false" do
        game_service.roll(first_pins_down)
        previous_turn = game_service.frame.rolls.first

        game_service.roll(second_pins_down)
        active_turn = game_service.frame.rolls.last

        expect(previous_turn.pins_down + active_turn.pins_down).not_to eq(10)
        expect(previous_turn.kind).to eq("regular")
        expect(active_turn.kind).to eq("regular")
      end
    end
    # add 4 rolls to check bonus logic
  end

  describe "get_current_score" do
    it "uses updated scores from calculate_bonus to return total score" do

      game_service.roll(5)
      game_service.roll(3)
      game_service.roll(10)
      game_service.roll(2)
      game_service.roll(4)

      total_score = game_service.get_current_score

      expect(total_score).to eq(30)
    end
  end
end
