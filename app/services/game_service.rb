class GameService
  def initialize
    @current_frame = 1
    @current_roll = 1
    @active_turn
    @previous_turn
    @score = 0
  end

  # def get_current_score
  #   Frame.all.(# do some chained methods of sums)
  #   # if strike? add next 2
  #   # if spare? add next 1
  #   @score
  # end

  def roll(pins_down)
    @frame = Frame.find_or_initialize_by(frame_number: @current_frame, score: @score)
    @active_turn = Roll.create(frame: @frame, roll_number: @current_roll, pins_down: pins_down)


    check_for_bonus

    @frame.save!
  end

  def check_for_bonus

    if @active_turn.roll_number == 1 &&  @active_turn.pins_down == 10
      @active_turn.update(bonus: true, kind: "strike")
      @current_frame += 1

    elsif @previous_turn.present? && @previous_turn.pins_down + @active_turn.pins_down == 10
      @active_turn.update(bonus: true, kind: "spare")
      @current_frame += 1

    elsif @previous_turn.present? && @previous_turn.pins_down + @active_turn.pins_down < 10
      @active_turn.update(bonus: false, kind: "regular")
      @current_frame += 1

    else
      @active_turn.update(bonus: false, kind: "regular")
      @previous_turn = @active_turn
      @current_roll += 1
    end
  end

  def strike?
    # next 2 rolls added to score
  end

  def spare?
    # next 1 roll from (current_frame + 1) added to score
  end

end
