# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :login_required

  def index
    redirect_to my_meetings_path if logged_in?
  end
end
