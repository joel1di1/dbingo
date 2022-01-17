# frozen_string_literal: true

class MeetingMembersController < ApplicationController
  def create
    @meeting = Meeting.find(params[:meeting_id])
    @meeting.add_member!(current_user)

    respond_to do |format|
      format.html do
        redirect_to meeting_url(@meeting), notice: 'Meeting joined!'
      end
      format.json { render :show, status: :created, location: @meeting }
    end
  end

  def destroy
    @meeting = Meeting.find(params[:meeting_id])
    @meeting.remove_member!(current_user)

    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Meeting member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
