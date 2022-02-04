# frozen_string_literal: true

class BetsController < ApplicationController
  before_action :set_bet, only: %i[show edit update destroy]
  before_action :set_meeting

  # GET /bets or /bets.json
  def index
    @bets = Bet.where(meeting: @meeting)
  end

  # POST /bets or /bets.json
  def create
    respond_to do |format|
      if current_user.bet_on!(@meeting, bet_params[:text])
        format.html { redirect_to meeting_url(@meeting), notice: 'Bet was successfully created.' }
        format.json { render :show, status: :created }
      end
    end
  end

  # DELETE /bets/1 or /bets/1.json
  def destroy
    @bet.destroy

    respond_to do |format|
      format.html { redirect_to meeting_url(@bet.meeting), notice: 'Bet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bet
    @bet = Bet.find(params[:id])
  end

  def set_meeting
    @meeting = current_user.meetings.find(params[:meeting_id])
  end

  # Only allow a list of trusted parameters through.
  def bet_params
    params.require(:bet).permit(:text)
  end
end
