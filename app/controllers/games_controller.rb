class GamesController < ApplicationController
  before_action :set_frames_and_score, only: [:index, :create]

  def index
    Rails.logger.info("********* current frame")
    Rails.logger.info(@current_frame)
    Rails.logger.info("********* total score")
    Rails.logger.info(@total_score)

    respond_to do |format|
      format.html
      format.json  { render json: { frames: @frames, current_frame: @current_frame, total_score: @total_score } }
    end
  end

  def create
    game_service = GameService.new(@current_frame)

    begin
      @current_frame, @total_score = game_service.roll(roll_params[:pins_down].to_i)

      respond_to do |format|
        format.html { redirect_to action: "index" }
        format.json { redirect_to json: { current_frame: @current_frame, total_score: @total_score } }
      end
    rescue StandardError => e
      flash[:error] = "Invalid roll: #{e.message}"
      redirect_to action: "index"
    end
  end

  private

    def set_frames_and_score
      @frames = Frame.all
      @total_score = @frames.sum(&:score)
      # @current_frame = @frames.any? ? @frames.last.frame_number + 1 : 1
    end

    def roll_params
      params.permit(:pins_down, :frame_number)
    end
end
