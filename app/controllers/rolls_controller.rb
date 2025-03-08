class RollsController < ApplicationController
  before_action :set_roll, only: %i[ show edit update destroy ]

  def index
    @rolls = Roll.all

    respond_to do |format|
      format.html
      format.json  { render :json => @rolls }
    end
  end

  def show
    @roll
  end


  def new
    @roll = Roll.new
  end


  def edit
  end


  def create
    @roll = Roll.new(roll_params)



    respond_to do |format|
      if @roll.save
        format.html { redirect_to @roll, notice: "Roll was successfully created." }
        format.json { render :show, status: :created, location: @roll }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @roll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /frames/1 or /frames/1.json
  def update
    respond_to do |format|
      if @roll.update(roll_params)
        format.html { redirect_to @roll, notice: "Roll was successfully updated." }
        format.json { render :show, status: :ok, location: @roll }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @roll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /frames/1 or /frames/1.json
  def destroy
    @roll.destroy!

    respond_to do |format|
      format.html { redirect_to rolls_path, status: :see_other, notice: "Roll was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_roll
      @roll = Roll.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def roll_params
      params.require(:roll).permit(:roll_number, :pins_down)
    end
end
