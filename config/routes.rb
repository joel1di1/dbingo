# frozen_string_literal: true

Rails.application.routes.draw do

  post '/auth/:provider/callback', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'

  root 'home#index'
end
