class GameService
  attr_reader :current_frame, :current_roll

  def initialize(current_frame, current_roll)
    @current_frame = current_frame
    @current_roll = current_roll
    @active_turn
    @score = 0
  end

  def get_current_score
    frames = Frame.all.order(:frame_number)
    frames.map(&:score).reduce(&:+)
  end

  def roll(pins_down)
    @frame = Frame.find_or_initialize_by(frame_number: @current_frame)
    @active_turn = Roll.create(frame: @frame, roll_number: @current_roll, pins_down: pins_down)

    check_for_bonus
    calculate_bonus
    get_current_score
  end

  def check_for_bonus
    if @active_turn.roll_number == 1 && @active_turn.pins_down == 10
      Rails.logger.info("********** STRIKE conditional")
      Rails.logger.info("current_frame: #{@current_frame}, current_roll: #{@current_roll}")
      @active_turn.frame.update!(score: 10)
      @active_turn.update!(bonus: true, kind: "strike")
      @current_frame += 1 unless @current_frame == 10

    elsif @frame.rolls.count > 0 && @frame.rolls.first.pins_down + @active_turn.pins_down == 10
      Rails.logger.info("********** SPARE conditional")
      Rails.logger.info("current_frame: #{@current_frame}, current_roll: #{@current_roll}")
      @active_turn.frame.update!(score: 10)
      @active_turn.update!(bonus: true, kind: "spare")
      @current_frame += 1 unless @current_frame == 10
      @current_roll = 1

    elsif @frame.rolls.count > 0 && @frame.rolls.first.pins_down + @active_turn.pins_down < 10
      Rails.logger.info("********** REGULAR conditional")
      Rails.logger.info("current_frame: #{@current_frame}, current_roll: #{@current_roll}")
      @active_turn.frame.update!(score: (@frame.score + @active_turn.pins_down))
      @active_turn.update!(bonus: false, kind: "regular")
      @current_frame += 1
      @current_roll = 1

    else
      Rails.logger.info("********** FIRST ROLL conditional")
      Rails.logger.info("current_frame: #{@current_frame}, current_roll: #{@current_roll}")
      @active_turn.frame.update!(score: @active_turn.pins_down)
      @active_turn.update!(bonus: false, kind: "regular")
      @current_roll += 1
    end

    @frame.save!
  end

  def calculate_bonus
    frames = Frame.all.order(:frame_number)
    return unless frames.count > 1

    previous_frame = frames[-2]

    case previous_frame.rolls.last.kind
    when "strike"
      updated_score = previous_frame.score + @active_turn.pins_down
      previous_frame.update!(score: updated_score)
    when "spare"
      updated_score = previous_frame.score + @active_turn.pins_down
      previous_frame.update!(score: updated_score)
    end
  end
end
