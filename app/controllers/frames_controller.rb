class FramesController < ApplicationController
  before_action :set_frame, only: %i[ show ]

  # GET /frames or /frames.json
  def index
    @frames = Frame.includes(:rolls).all

    respond_to do |format|
      format.html
      format.json  { render :json => @frames }
    end
  end

  # GET /frames/1 or /frames/1.json
  def show
    @frame
  end

  # GET /frames/new
  def new
    @frame = Frame.new
  end

  # GET /frames/1/edit
  # def edit
  # end

  # POST /frames or /frames.json
  def create
    @frame = Frame.new(frame_params)

    respond_to do |format|
      if @frame.save
        format.html { redirect_to @frame, notice: "Frame was successfully created." }
        format.json { render :show, status: :created, location: @frame }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @frame.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /frames/1 or /frames/1.json
  # def update
  #   respond_to do |format|
  #     if @frame.update(frame_params)
  #       format.html { redirect_to @frame, notice: "Frame was successfully updated." }
  #       format.json { render :show, status: :ok, location: @frame }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @frame.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /frames/1 or /frames/1.json
  # def destroy
  #   @frame.destroy!

  #   respond_to do |format|
  #     format.html { redirect_to frames_path, status: :see_other, notice: "Frame was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_frame
      @frame = Frame.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def frame_params
      params.require(:frame).permit(:frame_number, :score)
    end
end
