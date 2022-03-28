# frozen_string_literal: true

class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[show]
  before_action :set_meeting_for_creator, only: %i[edit update destroy]
  before_action :only_creator, only: %i[edit update destroy]

  # GET /meetings or /meetings.json
  def index
    @meetings = current_user.meetings.order(start_at: :desc)
  end

  # GET /meetings/1 or /meetings/1.json
  def show
    @my_bets = current_user.bets_on(@meeting) if current_user.member_of?(@meeting)
    @other_bets = Bet.where(meeting: @meeting).where.not(user:current_user)
    @new_bet = Bet.new
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings or /meetings.json
  def create
    @meeting = new_meeting_from_params

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to meeting_url(@meeting), notice: 'Meeting was successfully created.' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1 or /meetings/1.json
  def update
    if meeting_params[:transcript]
      @meeting.transcript.purge
      @meeting.transcript.attach(meeting_params[:transcript])
      @meeting.transcript_text = @meeting.transcript.download
    end
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to meeting_url(@meeting), notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1 or /meetings/1.json
  def destroy
    @meeting.destroy!

    respond_to do |format|
      format.html { redirect_to my_meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def only_creator
    redirect_to root_url unless @meeting.creator == current_user
  end

  private

  def new_meeting_from_params
    meeting = Meeting.new(meeting_params)
    meeting.creator = current_user
    meeting
  end

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def set_meeting_for_creator
    @meeting = Meeting.where(creator: current_user).find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:title, :start_at, :end_at, :transcript)
  end
end
