# frozen_string_literal: true

Rails.application.routes.draw do
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get '/sign_out', to: 'sessions#destroy'

  root 'home#index'
end
