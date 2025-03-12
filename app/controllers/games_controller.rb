class GamesController < ApplicationController
  before_action :set_frames_and_score, only: [:index, :create]

  def index
    @current_frame = if session[:current_frame].to_i < 11
      session[:current_frame]
    else
      "Game Over!"
    end

    respond_to do |format|
      format.html
    end
  end

  def create
    current_frame = session[:current_frame] || 1
    current_roll = session[:current_roll] || 1
    current_game_service = game_service(current_frame, current_roll)
    @total_score = current_game_service.roll(roll_params[:pins_down].to_i)

    session[:current_frame] = current_game_service.current_frame
    session[:current_roll] = current_game_service.current_roll

    redirect_to games_path
  end

  def destroy
    Frame.destroy_all
    session[:current_frame] = nil
    session[:current_roll] = nil

    redirect_to games_path
  end

  private

    def set_frames_and_score
      @frames = Frame.all.order(:frame_number)
      @total_score = @frames.sum(&:score)
    end

    def roll_params
      params.permit(:pins_down, :frame_number)
    end

    def game_service(current_frame, current_roll)
      GameService.new(current_frame, current_roll)
    end
end
