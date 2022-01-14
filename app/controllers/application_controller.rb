
# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :login_required

  helper_method :current_user

  def current_user
    return if session[:user_id].blank?

    @current_user ||= User.find_by(id: session[:user_id])
  end

  def login_required
    session[:url_after_sign_in] = request.url.gsub('signout', '')
    redirect_to new_session_path unless logged_in?
  end

  def logged_in?
    !!current_user
  end

end
