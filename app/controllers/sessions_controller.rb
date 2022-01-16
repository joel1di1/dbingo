# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :login_required, only: :create
  skip_forgery_protection

  def create
    email = params[:email] if Rails.env.test?
    email ||= request.env['omniauth.auth']['info']['email']

    user = User.find_or_create_by!(email:)
    session[:user_id] = user.id

    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil

    redirect_to root_path
  end
end
